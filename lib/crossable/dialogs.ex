defmodule Crossable.Dialogs do
  @moduledoc """
  The Dialogs context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo

  @doc """
  Creates a new dialog flow.
  """
  def create_dialog_flow(attrs \\ %{}) do
    %Crossable.Schema.Dialogs.DialogFlow{}
    |> Crossable.Schema.Dialogs.DialogFlow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a new dialog message. A dialog message exists as one of many in a dialog flow.
  """
  def create_dialog_message(attrs \\ %{}) do
    %Crossable.Schema.Dialogs.DialogMessage{}
    |> Crossable.Schema.Dialogs.DialogMessage.changeset(attrs)
    |> Repo.insert()
  end

  @spec assign_dialog_flow_to_channel(String.t(), integer()) :: any
  def assign_dialog_flow_to_channel(channel_id, dialog_flow_id) do
    %Crossable.Schema.Dialogs.DiscordChannelDialogFlow{}
    |> Crossable.Schema.Dialogs.DiscordChannelDialogFlow.changeset(%{
      discord_channel_id: channel_id,
      active: true,
      dialog_flow_id: dialog_flow_id,
      sequence_position: 1
    })
    |> Repo.insert()
  end
end
