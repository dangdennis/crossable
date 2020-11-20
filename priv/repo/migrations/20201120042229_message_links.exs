defmodule Crossable.Repo.Migrations.MessageLinks do
  use Ecto.Migration

  def change do
    create table(:message_links) do
      add :chain_id, :integer
      add :sequence_position, :integer
      add :name, :string
      add :content, :string
      add :response_match, :string
      timestamps()
      add :deleted_at, :utc_datetime
    end

    create unique_index(:message_links, [:chain_id, :sequence_position, :response_match], name: :message_links_chain_id_sequence_position_response_match_index)

    alter table(:message_links) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create table(:message_link_cursors) do
      add :user_id, references(:users)
      add :message_link_id, references(:message_links)
      timestamps()
      add :deleted_at, :utc_datetime
    end

    alter table(:message_link_cursors) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end
  end
end
