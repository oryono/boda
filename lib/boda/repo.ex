defmodule Boda.Repo do
  use Ecto.Repo,
    otp_app: :boda,
    adapter: Ecto.Adapters.Postgres
end
