defmodule Crossable.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo

  @doc """
  Records a sent discord message.
  """
  def create_discord_message(attrs \\ %{}) do
    %Crossable.Schema.Messages.DiscordMessage{}
    |> Crossable.Schema.Messages.DiscordMessage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a new dialog link. A dialog link exists as one of many in a dialog flow.
  """
  def create_dialog_link(attrs \\ %{}) do
    %Crossable.Schema.Dialogs.DialogLink{}
    |> Crossable.Schema.Dialogs.DialogLink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a new dialog link cursor for a user.
  """
  def create_dialog_link_cursor(attrs \\ %{}) do
    %Crossable.Schema.Dialogs.DialogLinkCursor{}
    |> Crossable.Schema.Dialogs.DialogLinkCursor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Moves a cursor along the flow.
  """
  def move_dialog_link_cursor(chain_id, next_seq_position) do

  end

  @doc """
  Send a message to designated public channels.
  """
  @spec broadcast_message(String.t()) :: :ok
  def broadcast_message(msg) do
    Enum.each(broadcast_channels(), fn ch ->
      Nostrum.Api.create_message(ch, msg)
    end)
  end

  @spec broadcast_channels :: [integer()]
  def broadcast_channels() do
    [746_529_655_133_175_952]
  end
end
