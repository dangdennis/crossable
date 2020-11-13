defmodule Crossable.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :deleted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all)
      add :balance, :float

      timestamps()
    end

    create unique_index(:wallets, [:user_id])

    alter table(:wallets) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
