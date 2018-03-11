defmodule TaxReceipts.Repo.Migrations.CreateDonors do
  use Ecto.Migration

  def change do
    create table(:donors) do
      add :name, :string
      add :amount, :integer
      add :address, :string

      timestamps()
    end

    create unique_index(:donors, [:name])
  end
end
