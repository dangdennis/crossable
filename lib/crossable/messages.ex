defmodule Crossable.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo

  def create_discord_message(attrs \\ %{}) do
    %Crossable.Schema.Messages.DiscordMessage{}
    |> Crossable.Schema.Messages.DiscordMessage.changeset(attrs)
    |> Repo.insert()
  end
end
