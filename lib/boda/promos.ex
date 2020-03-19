defmodule Boda.Promos do
  @moduledoc """
  The Promos context.
  """

  import Ecto.Query, warn: false
  alias Boda.Repo

  alias Boda.Promos.Promo

  @doc """
  Returns the list of promos.

  ## Examples

      iex> list_promos()
      [%Promo{}, ...]

  """
  def list_promos do
    Repo.all(Promo)
  end

  @doc """
  Gets a single promo.

  Raises `Ecto.NoResultsError` if the Promo does not exist.

  ## Examples

      iex> get_promo!(123)
      %Promo{}

      iex> get_promo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promo!(id), do: Repo.get!(Promo, id)

  @doc """
  Creates a promo.

  ## Examples

      iex> create_promo(%{field: value})
      {:ok, %Promo{}}

      iex> create_promo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promo(attrs \\ %{}) do
    %Promo{}
    |> Promo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promo.

  ## Examples

      iex> update_promo(promo, %{field: new_value})
      {:ok, %Promo{}}

      iex> update_promo(promo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promo(%Promo{} = promo, attrs) do
    promo
    |> Promo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a promo.

  ## Examples

      iex> delete_promo(promo)
      {:ok, %Promo{}}

      iex> delete_promo(promo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promo(%Promo{} = promo) do
    Repo.delete(promo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promo changes.

  ## Examples

      iex> change_promo(promo)
      %Ecto.Changeset{source: %Promo{}}

  """
  def change_promo(%Promo{} = promo) do
    Promo.changeset(promo, %{})
  end
end