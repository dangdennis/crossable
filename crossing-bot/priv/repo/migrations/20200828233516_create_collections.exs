defmodule Crossing.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :name, :string, null: false
      add :deleted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
