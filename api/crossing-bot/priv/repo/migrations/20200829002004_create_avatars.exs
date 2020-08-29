defmodule Crossing.Repo.Migrations.CreateAvatars do
  use Ecto.Migration

  def change do
    create table(:avatars) do
      add :user_id, references(:users), null: false
      add :deleted_at, :utc_datetime

      timestamps()
    end

    alter table(:avatars) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
