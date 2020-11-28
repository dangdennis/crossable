defmodule Crossable.Schema.Dialogs.DiscordChannelDialogFlow do
  @moduledoc """
  A join table between discord channels and dialog flows.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "discord_channels_dialog_flows" do
    field :discord_channel_id, :string
    belongs_to :dialog_flow, Crossable.Schema.Dialogs.DialogFlow
    field :active, :boolean
    field :sequence_position, :float
    timestamps()
    field :deleted_at, :utc_datetime
  end

  @doc false
  def changeset(join_row, attrs) do
    join_row
    |> cast(attrs, [
      :discord_channel_id,
      :active,
      :dialog_flow_id,
      :sequence_position,
      :deleted_at
    ])
    |> validate_required([:discord_channel_id, :active, :dialog_flow_id])
    |> unique_constraint([:discord_channel_id, :dialog_flow_id],
      name: :discord_channels_dialog_flows_discord_channel_id_dialog_flow_id
    )
  end
end
