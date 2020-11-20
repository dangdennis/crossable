defmodule Crossable.Repo.Migrations.CreateRaidAttack do
  use Ecto.Migration

  def change do
    create table(:raid_attacks) do
      add :raid_id, references(:raids)
      add :raid_member_id, references(:raid_members)
      timestamps()
      add :deleted_at, :utc_datetime
    end

    alter table(:raid_attacks) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
