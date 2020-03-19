defmodule BodaWeb.PromoControllerTest do
  use BodaWeb.ConnCase

  alias Boda.Promos
  alias Boda.Promos.Promo

  @create_attrs %{
    amount: "120.50",
    expiry_date: ~D[2010-04-17],
    is_active: true,
    is_expired: false,
    radius: 42
  }
  @update_attrs %{
    amount: "456.70",
    expiry_date: ~D[2011-05-18],
    is_active: false,
    is_expired: false,
    radius: 43
  }
  @invalid_attrs %{amount: nil, expiry_date: nil, is_active: nil, is_expired: nil, radius: nil}

  def fixture(:promo) do
    {:ok, promo} = Promos.create_promo(@create_attrs)
    promo
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all promos", %{conn: conn} do
      conn = get(conn, Routes.promo_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promo" do
    test "renders promo when data is valid", %{conn: conn} do
      conn = post(conn, Routes.promo_path(conn, :create), promo: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promo_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => "120.50",
               "code" => _,
               "expiry_date" => "2010-04-17",
               "is_active" => true,
               "is_expired" => false,
               "radius" => 42
             } = json_response(conn, 200)["data"]
    end

    test "returns promo code details when within the right radius", %{conn: conn} do
      post(conn, Routes.promo_path(conn, :create), promo: @create_attrs)
      conn = get(conn, Routes.promo_path(conn, :index))
      promo = List.first(json_response(conn, 200)["data"])
      conn = get(
        conn,
        Routes.promo_path(conn, :details, Map.get(promo, "code"), %{origin: "Kampala", destination: "Luzira"})
      ) # Should figure out away to mock this
      details = conn
                |> json_response(200)
      assert %{
               # Assert response has a polyline and a promo
               "polyline" => polyline,
               "promo" => promo
             } = details
    end

    test "returns promo code details when not within radius", %{conn: conn} do
      post(conn, Routes.promo_path(conn, :create), promo: @create_attrs)
      conn = get(conn, Routes.promo_path(conn, :index))
      promo = List.first(json_response(conn, 200)["data"])
      conn = get(
        conn,
        Routes.promo_path(conn, :details, Map.get(promo, "code"), %{origin: "Kampala", destination: "Nakasongola"})
      ) # Should figure out away to mock this

      details = conn
                |> json_response(400)

      assert %{
               "errors" => %{ # Make sure an error is there
                 "detail" => "This code can only be used within a radius of 42 km"
               }
             } = details
    end

    test "returns promo code details when code is expired or not active", %{conn: conn} do
      post(conn, Routes.promo_path(conn, :create), promo: @update_attrs)
      conn = get(conn, Routes.promo_path(conn, :index))
      promo = List.first(json_response(conn, 200)["data"])
      conn = get(
        conn,
        Routes.promo_path(conn, :details, Map.get(promo, "code"), %{origin: "Kampala", destination: "Nakasongola"})
      ) # Should figure out away to mock this

      details = conn
                |> json_response(400)

      assert %{
               "errors" => %{ # Make sure an error is there
                 "detail" => "This promo code has either expired or not active"
               }
             } = details
    end

    test "returns only active promos", %{conn: conn} do
      conn = post(conn, Routes.promo_path(conn, :create), promo: @create_attrs)
      conn = get(conn, Routes.promo_path(conn, :active))

      active_promo = List.first(
        json_response(conn, 200)["data"]
      ) # This returns an active promo since the @create_attrs creates an active promo

      assert %{
               "id" => id,
               "amount" => "120.50",
               "code" => _,
               "expiry_date" => "2010-04-17",
               "is_active" => true,
               "is_expired" => false,
               "radius" => 42
             } = active_promo # It's there, and it's active

      conn = put(conn, Routes.promo_path(conn, :update, Promos.get_promo!(id)), promo: @update_attrs)
      conn = get(conn, Routes.promo_path(conn, :active))
      active_promo = json_response(conn, 200)["data"] # After update this will be empty
      assert [
             ] = active_promo # We are asserting that if the active promo is updated to be ! active, then if we query we should have an empty list

    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.promo_path(conn, :create), promo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promo" do
    setup [:create_promo]

    test "renders promo when data is valid", %{conn: conn, promo: %Promo{id: id} = promo} do
      conn = put(conn, Routes.promo_path(conn, :update, promo), promo: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promo_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => "456.70",
               "code" => _, # This is autogenerated, it will always change
               "expiry_date" => "2011-05-18",
               "is_active" => false,
               "is_expired" => false,
               "radius" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, promo: promo} do
      conn = put(conn, Routes.promo_path(conn, :update, promo), promo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promo" do
    setup [:create_promo]

    test "deletes chosen promo", %{conn: conn, promo: promo} do
      conn = delete(conn, Routes.promo_path(conn, :delete, promo))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.promo_path(conn, :show, promo))
      end
    end
  end

  defp create_promo(_) do
    promo = fixture(:promo)
    {:ok, promo: promo}
  end
end
