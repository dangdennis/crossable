defmodule Crossable.Commands.Bomb do
  alias Crossable.Users

  def invoke(msg) do
    with {:ok, user} <- Users.get_user_by_discord_id(msg.author.id |> Integer.to_string()),
         {:ok, _user} <- Users.delete_user(%Crossable.Schema.Users.User{id: user.id}) do
      Nostrum.Api.create_message!(msg.channel_id, """
      Your account and data has been thoroughly deleted. Like as in, I don't know you know anymore.
      """)
    else
      {:error, _reason} ->
        nil

      _ ->
        nil
    end
  end
end
