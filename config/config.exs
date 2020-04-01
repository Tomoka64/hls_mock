# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :hls_mock, HlsMockWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WvgE2dqBx57cXtVMEcbAAlnf2iqu7r5FF4tvBXM/4Rz3+jTjnliikq7Zt66XE3uD",
  render_errors: [view: HlsMockWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: HlsMock.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "+P0jiekJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
