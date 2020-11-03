# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rss_reader,
  ecto_repos: [RssReader.Repo]

# Configures the endpoint
config :rss_reader, RssReaderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GHEegNmRwqzlP1szD54PBrMvUqWIievJWn+/pO+gEFZdec0SKqKBoZPqS5331Dsn",
  render_errors: [view: RssReaderWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RssReader.PubSub,
  live_view: [signing_salt: "7sckZOjJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
