defmodule Crossing.Repo.Migrations.CreateAvatars do
  use Ecto.Migration

  def change do
    create table(:avatars) do
      add :deleted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:avatars, [:user_id])

    alter table(:users) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
