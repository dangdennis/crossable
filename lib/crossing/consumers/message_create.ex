defmodule Crossable.Consumers.MessageCreate do
  @moduledoc "Handles the `MESSAGE_CREATE` gateway event."

  alias Nostrum.Struct.Message
  alias Crossable.Users

  @spec handle(Message.t()) :: :ok | nil
  def handle(msg) do
    unless msg.author.bot do
      case Users.get_user_by_discord_id(msg.author.id |> Integer.to_string()) do
        {:ok, _} ->
          nil

        {:error, _} ->
          case Users.create_user(%{
                 discord_user_id: msg.author.id |> Integer.to_string(),
                 avatar: %{}
               }) do
            {:ok, _user} ->
              Nostrum.Api.create_message(
                msg.channel_id,
                """
                Welcome to Health Crossable! You're all set!

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

      Crossable.Commands.Commander.handle(msg)
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
