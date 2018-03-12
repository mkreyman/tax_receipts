use Mix.Config

config :tax_receipts, ecto_repos: [TaxReceipts.Repo]

if Mix.env() == :dev do
  config :mix_test_watch,
    setup_tasks: ["ecto.reset"],
    ansi_enabled: :ignore,
    clear: true
end

# configuration for the PdfGenerator
config :pdf_generator, pdf_options: [
  "--print-media-type",
  "--page-size",
  "Letter",
  "--dpi",
  "150",
  "--zoom",
  "3",
  "--margin-top",
  "8",
  "--margin-right",
  "8",
  "--margin-bottom",
  "8",
  "--margin-left",
  "8"
]

config :tax_receipts,
  output_dir: "output",
  templates_dir: "templates",
  template: "tax_receipt.eex",
  logo: "logo.png",
  tmp_dir: System.tmp_dir()  # don't change, as it's hardcoded in PdfGenerator

import_config "#{Mix.env()}.exs"
