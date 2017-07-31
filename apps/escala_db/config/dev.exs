use Mix.Config

config :escala_db, EscalaDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "escala_db_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
