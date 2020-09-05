defmodule Crossing.Repo.Migrations.CreateRaidMembers do
  use Ecto.Migration

  def change do
    create table(:raid_members) do
      add :status, :string
      add :active, :boolean, default: true, null: false
      add :deleted_at, :utc_datetime
      add :raid_id, references(:raids, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:raid_members, [:raid_id])
    create index(:raid_members, [:user_id])

    alter table(:raid_members) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
