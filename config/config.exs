# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ticketing_system,
  ecto_repos: [TicketingSystem.Repo]

# Configures the endpoint
config :ticketing_system, TicketingSystemWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WVqjZFChZMZcgwWtJzyspCPp9e5JsCuyT2mp2m7sy32z5c/XCJ7yEPUaYuPA8dWa",
  render_errors: [view: TicketingSystemWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TicketingSystem.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :cloak, Cloak.AES.CTR,
  tag: "AES",
  default: true,
  keys: [
    %{
      tag: <<1>>,
      key: :base64.decode("2CJtBImYfIdlBKR0164Ys6xg+lAWaqaCVUrlK9OIKUE="),
      default: true
    }
  ]

  config :cloak, :migration,
  repo: TicketingSystem.Repo,
  models: [{TicketingSystem.Accounts.User, :encryption_version}]

  config :ticketing_system, :role_home_page, %{
    admin: "/admin/users",
    developer: "/admin/users",
    operator: "/ticket"
  }

  config :ticketing_system, :role_scopes, %{
    admin: ["admin"],
    developer: ["admin"],
    operator: ["ticket"]
  }
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
