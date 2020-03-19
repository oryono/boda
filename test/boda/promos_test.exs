defmodule Boda.PromosTest do
  use Boda.DataCase

  alias Boda.Promos

  describe "promos" do
    alias Boda.Promos.Promo

    @valid_attrs %{amount: "120.50", expiry_date: ~D[2010-04-17], is_active: true, is_expired: true, radius: 42}
    @update_attrs %{amount: "456.7", expiry_date: ~D[2011-05-18], is_active: false, is_expired: false, radius: 43}
    @invalid_attrs %{amount: nil, expiry_date: nil, is_active: nil, is_expired: nil, radius: nil}

    def promo_fixture(attrs \\ %{}) do
      {:ok, promo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Promos.create_promo()

      promo
    end

    test "list_promos/0 returns all promos" do
      promo = promo_fixture()
      assert Promos.list_promos() == [promo]
    end

    test "get_promo!/1 returns the promo with given id" do
      promo = promo_fixture()
      assert Promos.get_promo!(promo.id) == promo
    end

    test "create_promo/1 with valid data creates a promo" do
      assert {:ok, %Promo{} = promo} = Promos.create_promo(@valid_attrs)
      assert promo.amount == Decimal.new("120.50")
      assert promo.expiry_date == ~D[2010-04-17]
      assert promo.is_active == true
      assert promo.is_expired == true
      assert promo.radius == 42
    end

    test "create_promo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promos.create_promo(@invalid_attrs)
    end

    test "update_promo/2 with valid data updates the promo" do
      promo = promo_fixture()
      assert {:ok, %Promo{} = promo} = Promos.update_promo(promo, @update_attrs)
      assert promo.amount == Decimal.new("456.7")
      assert promo.expiry_date == ~D[2011-05-18]
      assert promo.is_active == false
      assert promo.is_expired == false
      assert promo.radius == 43
    end

    test "update_promo/2 with invalid data returns error changeset" do
      promo = promo_fixture()
      assert {:error, %Ecto.Changeset{}} = Promos.update_promo(promo, @invalid_attrs)
      assert promo == Promos.get_promo!(promo.id)
    end

    test "delete_promo/1 deletes the promo" do
      promo = promo_fixture()
      assert {:ok, %Promo{}} = Promos.delete_promo(promo)
      assert_raise Ecto.NoResultsError, fn -> Promos.get_promo!(promo.id) end
    end

    test "change_promo/1 returns a promo changeset" do
      promo = promo_fixture()
      assert %Ecto.Changeset{} = Promos.change_promo(promo)
    end
  end
end
