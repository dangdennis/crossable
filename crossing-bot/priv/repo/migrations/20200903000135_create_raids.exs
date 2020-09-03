defmodule Crossing.Repo.Migrations.CreateRaids do
  use Ecto.Migration

  def change do
    create table(:raids) do
      add :player_limit, :integer
      add :status, :string
      add :end_time, :utc_datetime
      add :deleted_at, :utc_datetime
      add :raid_boss_id, references(:raid_bosses, on_delete: :nothing)

      timestamps()
    end

    create index(:raids, [:raid_boss_id])
  end
end
