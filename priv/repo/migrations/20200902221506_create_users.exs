defmodule Crossable.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :discord_user_id, :string
      add :username, :string
      add :password_hash, :string
      add :active, :boolean
      timestamps()
      add :deleted_at, :utc_datetime
    end

    create unique_index(:users, [:discord_user_id])

    alter table(:users) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
