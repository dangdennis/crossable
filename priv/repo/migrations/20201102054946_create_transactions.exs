defmodule Crossable.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do

      timestamps()
    end

  end
end
