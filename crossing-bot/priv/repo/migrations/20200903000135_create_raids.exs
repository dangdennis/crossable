defmodule Crossing.Repo.Migrations.CreateRaids do
  use Ecto.Migration

  def change do
    create table(:raids) do
      add :player_limit, :integer
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :deleted_at, :utc_datetime
      add :raid_boss_id, references(:raid_bosses, on_delete: :delete_all)
      add :completion_percentage, :float
      add :active, :boolean

      timestamps()
    end

    create index(:raids, [:raid_boss_id])

    alter table(:raids) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
