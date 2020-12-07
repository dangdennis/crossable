defmodule Elixir.Crossable.Repo.Migrations.PartialndexForDialogMessage do
  use Ecto.Migration

  def change do
    create unique_index(:dialog_messages, [:dialog_flow_id, :sequence_position], where: "response_match is null")
  end
end
