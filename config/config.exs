# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# config :umi_clicker,
#   ecto_repos: [UmiClicker.Repo]

# Configures the endpoint
config :umi_clicker, UmiClickerWeb.Endpoint,
  url: [host: "127.0.0.1"],
  check_origin: [
    "http://localhost:8080",
    "https://umiumi.net",
    "//*.umiumi.net",
    "//happybirthday2019.umiumi.net"
  ],
  secret_key_base: "VGlt7vbto3ZXbsFRFsmnAs1aNjdKFB5TOEcY3LRmtsEsbdPTPg0jDuWvzv8JeyFG",
  render_errors: [view: UmiClickerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UmiClicker.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
