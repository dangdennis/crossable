defmodule Crossable.Repo.Migrations.CreateAvatars do
  use Ecto.Migration

  def change do
    create table(:avatars) do
      add :user_id, references(:users)
      timestamps()
      add :deleted_at, :utc_datetime
    end

    create index(:avatars, [:user_id], unique: true)

    alter table(:users) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
