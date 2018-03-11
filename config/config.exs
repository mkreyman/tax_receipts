use Mix.Config

config :tax_receipts, ecto_repos: [TaxReceipts.Repo]

if Mix.env() == :dev do
  config :mix_test_watch,
    setup_tasks: ["ecto.reset"],
    ansi_enabled: :ignore,
    clear: true
end

config :tax_receipts, temp_dir: "./tmp/"

import_config "#{Mix.env()}.exs"
