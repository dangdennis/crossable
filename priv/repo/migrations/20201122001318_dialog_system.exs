defmodule Crossable.Repo.Migrations.DialogSystem do
  use Ecto.Migration

  def change do
    drop table("message_link_cursors")
    drop table("message_links")

    create table(:dialog_links) do
      add :flow_id, :integer
      add :sequence_position, :integer
      add :name, :string
      add :content, :string
      add :response_match, :string
      timestamps()
      add :deleted_at, :utc_datetime
    end

    create unique_index(:dialog_links, [:flow_id, :sequence_position, :response_match], name: :message_links_chain_id_sequence_position_response_match_index)

    alter table(:dialog_links) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create table(:dialog_flows) do
      add :name, :string
      timestamps()
      add :deleted_at, :utc_datetime
    end

    alter table(:dialog_flows) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:dialog_flows, [:name])

    create table(:discord_channels_dialog_flows) do
      add :discord_channel_id, :string
      add :dialog_flow_id, references(:dialog_flows)
      add :active, :boolean
      add :sequence_position, :float
      timestamps()
      add :deleted_at, :utc_datetime
    end

    alter table(:discord_channels_dialog_flows) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    create unique_index(:discord_channels_dialog_flows, [:discord_channel_id, :dialog_flow_id])
  end
end
