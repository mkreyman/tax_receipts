use Mix.Config

config :tax_receipts, ecto_repos: [TaxReceipts.Repo]

if Mix.env() == :dev do
  config :mix_test_watch,
    setup_tasks: ["ecto.reset"],
    ansi_enabled: :ignore,
    clear: true
end

config :tax_receipts,
  output_dir: "output",
  templates_dir: "templates",
  template: "tax_receipt.eex",
  logo: "logo.png",
  # don't change, as it's hardcoded in PdfGenerator
  tmp_dir: System.tmp_dir()

import_config "#{Mix.env()}.exs"
