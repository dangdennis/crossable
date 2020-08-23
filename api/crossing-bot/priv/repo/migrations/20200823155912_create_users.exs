defmodule Crossing.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :username, :string, null: false, unique: true
      add :email, :string
      add :password_hash, :string
      add :password, :string, virtual: true

      timestamps()
    end
  end
end
