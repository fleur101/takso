# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :takso,
  ecto_repos: [Takso.Repo]

# Configures the endpoint
config :takso, TaksoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+gIrFLa+U4iqxJ1GrQJCPktypUkT+WdSDR8JLbdMCICgV5Qzcfsva9olAwt/nbre",
  render_errors: [view: TaksoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Takso.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :takso, Takso.Guardian,
  issuer: "takso",
  secret_key: "2MzZUajDC1KViGkpRYZfhvSsoVtVdBzshOkvDI9Dk8WP4rjrBEFTlNWbdjARrjsF"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
