defmodule Crossable.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
        add :deleted_at, :utc_datetime
        add :amount, :float
        add :wallet_id, references(:wallets)

        timestamps()
    end

    alter table(:transactions) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
