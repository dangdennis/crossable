defmodule Crossable.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :user_id, references(:users)
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :email, :string
      add :phone_number, :string
      timestamps()
      add :deleted_at, :utc_datetime

    end

    create index(:profiles, [:user_id])

    alter table(:profiles) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
