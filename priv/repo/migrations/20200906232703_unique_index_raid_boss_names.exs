defmodule Crossable.Repo.Migrations.UniqueIndexRaidBossNames do
  use Ecto.Migration

  def change do
    create unique_index(:raid_bosses, [:name])
  end
end
