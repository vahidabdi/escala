use Mix.Config

config :escala_db, EscalaDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "escala_db_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger,
  backends: [:console],
  compile_time_purge_level: :debug
