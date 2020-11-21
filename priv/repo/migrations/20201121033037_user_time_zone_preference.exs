defmodule Crossable.Repo.Migrations.UserTimeZonePreference do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :time_zone, :string
    end
  end
end
