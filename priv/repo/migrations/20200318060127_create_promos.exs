defmodule Boda.Repo.Migrations.CreatePromos do
  use Ecto.Migration

  def change do
    create table(:promos) do
      add :code, :string, null: false
      add :amount, :decimal, precision: 10, scale: 2
#      add :event_id, references(:events, on_delete: :nothing)
      add :expiry_date, :date
      add :is_expired, :boolean, default: false, null: false
      add :is_active, :boolean, default: true, null: false
      add :radius, :integer

      timestamps()
    end

    create unique_index(:promos, [:code])

  end

end
