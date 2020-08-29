defmodule Crossing.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false, unique: true
      add :email, :string, unique: true
      add :phone_number, :string, unique: true
      add :password_hash, :string
      add :password, :string, virtual: true
      add :deleted_at, :utc_datetime

      timestamps()
    end
  end
end
