# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :naval_batlle, NavalBatlleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kZQFqNybD0hWk0J/i8btYjDBjsgoQWQt3HjZf9Pg6k9EO+EKIcJib7a29v6wePdU",
  render_errors: [view: NavalBatlleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NavalBatlle.PubSub,
  live_view: [signing_salt: "wqH0KvSN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
