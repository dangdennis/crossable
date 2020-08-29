defmodule Crossing.Repo.Migrations.CreateActionTypes do
  use Ecto.Migration

  def change do
    create table(:action_types) do
      add :name, :string
      add :deleted_at, :utc_datetime

      timestamps()
    end

    alter table(:action_types) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    alter table(:actions) do
      add :action_type_id, references(:action_types), null: false
    end
  end
end
