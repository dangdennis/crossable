defmodule Crossing.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string, null: false
      add :image_url, :string
      add :deleted_at, :utc_datetime
      add :collection_id, references(:collections)

      timestamps()
    end
  end
end
