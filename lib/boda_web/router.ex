defmodule BodaWeb.Router do
  use BodaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BodaWeb do
    pipe_through :api

    resources "/promos", PromoController, except: [:new, :edit]
    get "/promos/status/active", PromoController, :active
    get "/promos/details/:code", PromoController, :details
  end
end
