defmodule TaxReceipts.Mixfile do
  use Mix.Project

  @name :tax_receipts
  @version "0.3.0"

  @deps [
    {:mix_test_watch, github: "aforward/mix-test.watch", only: :dev, runtime: false},
    {:postgrex, "~> 0.13.2"},
    {:ecto, "~> 2.1"},
    {:poison, "~> 3.1.0"},
    {:ex_doc, ">= 0.0.0", only: :dev},
    {:csv, "~> 2.0.0"},
    {:pdf_generator, "~> 0.6.2"}
  ]

  @aliases [
    "ecto.reset": ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate"],
    "test.once": ["ecto.reset", "test"]
  ]

  # ------------------------------------------------------------

  def project do
    in_production = Mix.env() == :prod

    [
      app: @name,
      version: @version,
      elixir: ">= 1.11.2",
      deps: @deps,
      aliases: @aliases,
      build_embedded: in_production
    ]
  end

  def application do
    [
      mod: {TaxReceipts.Application, []},
      extra_applications: [
        :logger,
        :pdf_generator
      ]
    ]
  end
end
