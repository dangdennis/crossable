# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :crossing,
  ecto_repos: [Crossing.Repo]

# Configures the endpoint
config :crossing, CrossingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D2TN0D0JY97FxvxIfO/HsX+nx0X7R/nT9HQZxbh1+REo34vlrwQJk+uFLzKQtdC1",
  render_errors: [view: CrossingWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Crossing.PubSub,
  live_view: [signing_salt: "zRuyz1E8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :nostrum,
  # The token of your bot as a string
  token: System.get_env("DISCORD_BOT_KEY"),

  # The number of shards you want to run your bot under, or :auto.
  num_shards: :auto

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
