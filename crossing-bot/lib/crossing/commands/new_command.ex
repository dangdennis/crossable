defmodule Crossing.Commands.New do
  alias Crossing.Users

  def invoke(msg) do
    case Users.create_user(%{
           discord_user_id: msg.author.id |> Integer.to_string(),
           avatar: %{}
         }) do
      {:ok, user} ->
        Nostrum.Api.create_message(
          msg.channel_id,
          """
          Welcome to Health Crossing! You're all set!

          Commonly used commands:
          !raid - learn what raid is happening this week
          !join - to join the week's raid
          !attack - confirm that you've completed your daily task, and deal some damage to the raid boss!
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
