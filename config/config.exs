# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :boda,
  ecto_repos: [Boda.Repo]

config :google_maps,
       api_key:   System.get_env("GOOGLE_MAPS_API_KEY") ||
         raise """
         Google maps api key is missing. Please obtain one, and remember to enable distance matrix api and directions api
         Use the command below to export the key to system variables.
         export GOOGLE_MAPS_API_KEY=your-key-here
         """

# Configures the endpoint
config :boda, BodaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m6GRIGKhWiAfhH79vKOqB8/lDKl4FDQFNKrDU+FS+2/t++3m7cHSR81lIvujt/G3",
  render_errors: [view: BodaWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Boda.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
