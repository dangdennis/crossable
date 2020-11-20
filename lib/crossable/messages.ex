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
  Creates a new message link.
  """
  def create_message_link(attrs \\ %{}) do
    %Crossable.Schema.Messages.MessageLink{}
    |> Crossable.Schema.Messages.MessageLink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a new message link cursor for a user.
  """
  def create_message_link_cursor(attrs \\ %{}) do
    %Crossable.Schema.Messages.MessageLinkCursor{}
    |> Crossable.Schema.Messages.MessageLinkCursor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Moves a cursor along the chain, or to a new chain.
  """
  def move_message_link_cursor(chain_id, next_seq_position) do

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
