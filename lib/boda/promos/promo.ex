defmodule Boda.Promos.Promo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promos" do
    field :amount, :decimal
    field :code, :string
    field :expiry_date, :date
    field :is_active, :boolean, default: true
    field :is_expired, :boolean, default: false
    field :radius, :integer

    timestamps()
  end

  @doc false
  def changeset(promo, attrs) do
    promo
    |> cast(attrs, [:code, :amount, :expiry_date, :is_expired, :is_active, :radius])
    |> validate_required([:amount, :expiry_date, :radius])
    |> unique_constraint(:code)
    |> set_promo_code
  end

  defp set_promo_code(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: _
      } ->
        put_change(changeset, :code, random_code())
      _ ->
        changeset
    end
  end

  def random_code do
    alphabet = Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9)
    length = 8

    Enum.take_random(alphabet, length) |> List.to_string
  end
end