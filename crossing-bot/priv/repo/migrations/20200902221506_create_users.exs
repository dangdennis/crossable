defmodule Crossing.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string
      add :phone_number, :string
      add :password_hash, :string
      add :deleted_at, :utc_datetime

      timestamps()
    end

    alter table(:users) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

  end
end
