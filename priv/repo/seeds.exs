# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Boda.Repo.insert!(%Boda.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Seeding some promos for testing purposes here
Boda.Promos.create_promo(%{amount: 30000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]), expiry_date: "2020-03-31"})
Boda.Promos.create_promo(%{amount: 40000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]),  expiry_date: "2020-03-31"})
Boda.Promos.create_promo(%{amount: 30000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]), expiry_date: "2020-03-31"})
Boda.Promos.create_promo(%{amount: 100000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]), expiry_date: "2020-03-31"})
Boda.Promos.create_promo(%{amount: 25000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]), expiry_date: "2020-03-31"})
Boda.Promos.create_promo(%{amount: 50000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]),  expiry_date: "2020-03-31"})
Boda.Promos.create_promo(%{amount: 20000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]), expiry_date: "2020-03-31"})
Boda.Promos.create_promo(%{amount: 50000, radius: :rand.uniform(5) * 10, is_active: Enum.random([true, false]),  expiry_date: "2020-03-31"})

