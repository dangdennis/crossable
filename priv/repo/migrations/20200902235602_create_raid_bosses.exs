defmodule Crossable.Repo.Migrations.CreateRaidBosses do
  use Ecto.Migration

  def change do
    create table(:raid_bosses) do
      add :name, :string
      add :image_url, :string
      add :deleted_at, :utc_datetime

      timestamps()
    end

    alter table(:raid_bosses) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
