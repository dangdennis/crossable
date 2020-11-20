defmodule Crossable.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :wallet_id, references(:wallets)
      add :amount, :float
      timestamps()
      add :deleted_at, :utc_datetime
    end

    alter table(:transactions) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
