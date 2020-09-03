defmodule Crossing.Consumer.MessageCreate do
  @moduledoc "Handles the `MESSAGE_CREATE` gateway event."

  alias Nostrum.Struct.Message
  alias Crossing.Users

  @spec handle(Message.t()) :: :ok | nil
  def handle(msg) do
    unless msg.author.bot do
      case String.split(msg.content, " ", trim: true) do
        ["!new" | _tail] ->
          IO.inspect(msg)

          case Users.create_user(%{
                 discord_user_id: msg.author.id |> Integer.to_string(),
                 username: msg.author.username
               }) do
            {:ok, user} ->
              Nostrum.Api.create_message(
                msg.channel_id,
                """
                Welcome to Health Crossing! You're all set!

                Commonly used commands:
                !raid - learn what raid is happening this week
                !help - get a list of all available commands
                !join - to join the week's raid
                !party - receive a list of party members
                !update - starts a new form to update your personal goals
                !status - receive a link to visit your stats

                Real serious commands:
                !bomb - deletes all your data, including your avatar and your health stats
                """
              )

              IO.inspect(user)

            {:error, changeset} ->
              Nostrum.Api.create_message(
                msg.channel_id,
                changeset |> error_response
              )
          end

        _ ->
          nil
      end
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
