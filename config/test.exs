use Mix.Config

config :tax_receipts, TaxReceipts.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "tax_receipts_#{Mix.env()}",
  username: "postgres",
  password: "",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger,
  backends: [:console],
  level: :warn,
  compile_time_purge_level: :info
