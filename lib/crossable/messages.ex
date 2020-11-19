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
    [746_529_655_133_175_952]
  end
end
