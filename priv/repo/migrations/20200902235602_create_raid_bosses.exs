defmodule Crossable.Repo.Migrations.CreateRaidBosses do
  use Ecto.Migration

  def change do
    create table(:raid_bosses) do
      add :name, :string
      add :image_url, :string
      timestamps()
      add :deleted_at, :utc_datetime
    end

    alter table(:raid_bosses) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:raid_bosses, [:name])
  end
end
