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
    # TODO move these channels to a database table
    channels = %{
      crossable_dev_general: 746_529_655_133_175_952,
      crossable_community_daily_update_channel: 748_927_605_520_203_836
    }

    Enum.map(channels, fn {_k, v} -> v end)
  end
end
