use Mix.Config

config :tax_receipts, TaxReceipts.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "tax_receipts_#{Mix.env}",
  username: "postgres",
  password: "",
  hostname: "localhost",
]

# configuration for the PdfGenerator
config :pdf_generator, :pdf_options,
  [
    "--print-media-type",
   "--page-size", "Letter",
   "--dpi", "150",
   "--zoom", "3",
   "--margin-top", "8",
   "--margin-right", "8",
   "--margin-bottom", "8",
   "--margin-left", "8"
]