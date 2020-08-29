defmodule Crossing.Repo.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :value, :float, null: false
      add :unit, :string, null: false
      add :deleted_at, :utc_datetime
      add :avatar_id, references(:actions), null: false

      timestamps()
    end

    alter table(:actions) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
