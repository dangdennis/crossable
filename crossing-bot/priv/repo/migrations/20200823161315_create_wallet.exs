defmodule Crossing.Repo.Migrations.CreateWallet do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :balance, :float, null: false, default: 0.0
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :deleted_at, :utc_datetime

      timestamps()
    end

    create index(:wallets, [:user_id])
  end
end
