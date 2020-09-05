defmodule Crossing.Commands.New do
  alias Crossing.Users
  alias Crossing.Avatars
  alias Nostrum.Struct.Message

  def invoke(msg) do
    case Users.create_user(%{
           discord_user_id: msg.author.id |> Integer.to_string(),
           username: msg.author.username
         }) do
      {:ok, user} ->
        IO.inspect(user)

        case Avatars.create_avatar_for_user(user) do
          {:ok, avatar} ->
            IO.inspect(avatar)

            Nostrum.Api.create_message(
              msg.channel_id,
              """
              Welcome to Health Crossing! You're all set!

              Commonly used commands:
              !raid - learn what raid is happening this week
              !join - to join the week's raid
              !party - receive a list of party members
              !help - get a list of all available commands

              Real serious commands:
              !bomb - deletes all your data
              """
            )

          {:error, changeset} ->
            Nostrum.Api.create_message(
              msg.channel_id,
              changeset |> error_response
            )
        end

      {:error, changeset} ->
        Nostrum.Api.create_message(
          msg.channel_id,
          changeset |> error_response
        )
    end
  end

  defp error_response(changeset) do
    Enum.map(changeset.errors, fn error ->
      case error do
        {:discord_user_id, _msg} ->
          "Your account is already registered."

        _ ->
          "Something went wrong."
      end
    end)
    |> Enum.join(" ")
  end
end
