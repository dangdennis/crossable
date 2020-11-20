defmodule Crossable.Repo.Migrations.CreateRaids do
  use Ecto.Migration

  def change do
    create table(:raids) do
      add :raid_boss_id, references(:raid_bosses)
      add :active, :boolean
      add :completion_percentage, :float
      add :player_limit, :integer
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      timestamps()
      add :deleted_at, :utc_datetime
    end

    create index(:raids, [:raid_boss_id])

    alter table(:raids) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
