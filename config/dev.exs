use Mix.Config

config :tax_receipts, TaxReceipts.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "tax_receipts_#{Mix.env()}",
  username: System.get_env("TAX_RECEIPTS_DB_USER"),
  password: System.get_env("TAX_RECEIPTS_DB_PASSWORD"),
  port: System.get_env("TAX_RECEIPTS_DB_PORT"),
  hostname: "localhost"
