defmodule Crossable.Consumer.MessageCreate do
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
                Welcome to Crossable! You're all set!

                Commands:
                !mindful - stay mindful and check-in for your habit progress!
                !wallet - see your token balance.
                """
              )

            {:error, changeset} ->
              Nostrum.Api.create_message(
                msg.channel_id,
                changeset |> error_response
              )
          end
      end

      Crossable.Commands.Invoker.handle(msg)
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
