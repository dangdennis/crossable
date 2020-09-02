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

          case Users.create_user(%{username: msg.author.username}) do
            {:ok, user} ->
              Nostrum.Api.create_message(
                msg.channel_id,
                """
                Welcome to Health Crossing! You're all set!

                Commonly used commands:
                !help - get a list of all available commands
                !join - to join the week's raid
                !raid - learn what raid is happening this week
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
                changeset.errors |> error_response
              )
          end

        _ ->
          nil
      end
    end
  end

  defp error_response(errors) do
    Enum.map(errors, fn error ->
      case error do
        {:username, _msg} ->
          "Your username is already registered."

        _ ->
          "Something went wrong."
      end
    end)
    |> Enum.join(" ")
  end
end
