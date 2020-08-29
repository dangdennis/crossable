defmodule Crossing.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :deleted_at, :utc_datetime

      timestamps()
    end

  end
end
