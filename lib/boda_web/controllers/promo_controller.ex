defmodule BodaWeb.PromoController do
  use BodaWeb, :controller

  alias Boda.Repo
  alias Boda.Promos
  alias Boda.Promos.Promo

  import Ecto.Query, only: [from: 2]

  action_fallback BodaWeb.FallbackController

  def index(conn, _params) do
    promos = Promos.list_promos()
    render(conn, "index.json", promos: promos)
  end

  def create(conn, %{"promo" => promo_params}) do
    with {:ok, %Promo{} = promo} <- Promos.create_promo(promo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promo_path(conn, :show, promo))
      |> render("show.json", promo: promo)
    end
  end

  def show(conn, %{"id" => id}) do
    promo = Promos.get_promo!(id)
    render(conn, "show.json", promo: promo)
  end

  def update(conn, %{"id" => id, "promo" => promo_params}) do
    promo = Promos.get_promo!(id)

    with {:ok, %Promo{} = promo} <- Promos.update_promo(promo, promo_params) do
      render(conn, "show.json", promo: promo)
    end
  end

  def delete(conn, %{"id" => id}) do
    promo = Promos.get_promo!(id)

    with {:ok, %Promo{}} <- Promos.delete_promo(promo) do
      send_resp(conn, :no_content, "")
    end
  end

  def details(conn, %{"code" => code, "destination" => destination, "origin" => origin}) do
    {
      :ok,
      %{
        "rows" => [
          %{
            "elements" => [
              %{
                "distance" => %{
                  "value" => distance
                }
              }
            ]
          }
        ]
      }
    } = GoogleMaps.distance(origin, destination)

    promo = Repo.get_by!(Promos.Promo, code: code)
    distance = distance / 1000
    cond do
      (promo.is_expired || !promo.is_active) -> conn
                                                |> put_status(400)
                                                |> json(
                                                     %{
                                                       errors: %{
                                                         detail: "This promo code has either expired or not active"
                                                       }
                                                     }
                                                   )

      distance > promo.radius -> conn
                                 |> put_status(400)
                                 |> json(
                                      %{
                                        errors: %{
                                          detail: "This code can only be used within a radius of #{promo.radius} km"
                                        }
                                      }
                                    )

      true -> {
                :ok,
                %{
                  "routes" => [
                    %{
                      "overview_polyline" => %{
                        "points" => polyline
                      }
                    }
                  ]
                }
              }
              = GoogleMaps.directions(origin, destination)
              render(conn, "details.json", %{promo: promo, polyline: polyline})
    end
  end

  def active(conn, _) do
    promos = Repo.all(from p in Promo, where: p.is_active == true)
    render(conn, "index.json", promos: promos)
  end
end