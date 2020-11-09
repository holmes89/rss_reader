# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :rss_reader,
  ecto_repos: [RssReader.Repo]

config :rss_reader_web,
  ecto_repos: [RssReader.Repo],
  generators: [context_app: :rss_reader]

# Configures the endpoint
config :rss_reader_web, RssReaderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Km6TPmxXx4UO5T/ao0LarWr92Cu3u3r3nspa2D3y7yvAN1nBrCrhm0bTpb4AgRjJ",
  render_errors: [view: RssReaderWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RssReader.PubSub,
  live_view: [signing_salt: "qbD9j50w"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
