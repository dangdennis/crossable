defmodule Crossing.Commands.Bomb do
  alias Crossing.Users

  def invoke(msg) do
    case Users.get_user_by_discord_id(msg.author.id |> Integer.to_string()) do
      nil ->
        nil

      user ->
        case Users.delete_user(%Crossing.Users.User{id: user.id}) do
          {:ok, _user} ->
            Nostrum.Api.create_message!(msg.channel_id, """
            Your account and data has been thoroughly deleted. Like as in, I don't know you know anymore.
            """)

          _ ->
            nil
        end
    end
  end
end
