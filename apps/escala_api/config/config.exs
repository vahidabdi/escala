# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :escala_api,
  namespace: EscalaApi

# Configures the endpoint
config :escala_api, EscalaApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dds/l/59GjS474tg/AIQdXIzBbIU+9jSbAMPBXbTlD9nCnMYqlzNyv02myFg6/4k",
  render_errors: [view: EscalaApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: EscalaApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "EscalaDb",
  ttl: {1, :year},
  verify_issuer: true, # optional
  secret_key: "k02B4EfQyy7pSGWABGrwVC6FdHCtGrWufhb/PswNKBDWIHCtmeX5CKaYQJ7Zm+qS",
  serializer: EscalaApi.GuardianSerializer


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
