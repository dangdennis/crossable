defmodule Crossable.Consumer.MessageCreate do
  @moduledoc "Handles the `MESSAGE_CREATE` gateway event."

  alias Nostrum.Struct.Message
  alias Crossable.Users
  alias Crossable.Avatars
  alias Crossable.Tokenomics

  @spec handle(Message.t()) :: :ok | nil
  def handle(msg) do
    unless msg.author.bot do
      case Users.get_user_by_discord_id(msg.author.id |> Integer.to_string()) do
        {:ok, _} ->
          nil

        {:error, _} ->
          # This should be done all in a transaction
          with {:ok, user} <-
                 Users.create_user(%{
                   discord_user_id: msg.author.id |> Integer.to_string(),
                   avatar: %{}
                 }),
               {:ok, _} <- Avatars.create_avatar_for_user(user),
               {:ok, _} <- Tokenomics.create_wallet_for_user(user) do
            Nostrum.Api.create_message(
              msg.channel_id,
              """
              Welcome to Crossable! You're all set!

              Commands:
              !mindful - stay mindful and check-in for your habit progress!
              !wallet - see your token balance.
              """
            )
          else
            {:error, changeset} ->
              Nostrum.Api.create_message(
                msg.channel_id,
                changeset |> error_response
              )

            _ ->
              nil
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
