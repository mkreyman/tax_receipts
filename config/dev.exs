use Mix.Config

config :tax_receipts, TaxReceipts.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "tax_receipts_#{Mix.env()}",
  username: System.get_env("DB_USER"),
  password: System.get_env("DB_PASSWORD"),
  hostname: "localhost"

