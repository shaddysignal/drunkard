# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :drunkard,
  ecto_repos: [ Drunkard.Repo ],
  generators: [ binary_id: true ]

# Configures the endpoint
config :drunkard, DrunkardWeb.Endpoint,
  url: [ host: "localhost" ],
  secret_key_base: "bmCQxkml5RyLy2rJ8psoPm3Aql3GXgsikmaxqNu8DBkhZDjQDCOTG7wKAQ9AxnwW",
  render_errors: [ view: DrunkardWeb.ErrorView, accepts: ~w(json) ],
  pubsub: [ name: Drunkard.PubSub, adapter: Phoenix.PubSub.PG2 ],
  live_view: [ signing_salt: "0x34oQIKMzUVXlkLwgUzgBRZn9JE8eUA" ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [ :request_id ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Common config for Repo
config :drunkard, Drunkard.Repo,
  migration_primary_key: [ name: :uuid, type: :binary_id ],
  migration_timestamps: [ type: :timestamptz ]

# Guardian
config :drunkard, Drunkard.Guardian,
  issuer: "drunkard",
  ttl: {30, :days},
  verify_issuer: true,
  key: :token_resource,
  secret_key: "bw4wGH7DsR8lspZ1vFpZELnUxEcpQRVMlLHlCQC4+mGgASGfwjxf+Dh+zpjDI3e9"

config :kernel,
  sync_nodes_optional: ["1@127.0.0.1", "2@127.0.0.1"],
  sync_nodes_timeout: 10_000

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
