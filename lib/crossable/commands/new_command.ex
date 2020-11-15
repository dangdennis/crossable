defmodule Crossable.Commands.New do
  alias Crossable.Users

  def invoke(msg) do
    with {:ok, user} <-
           Users.create_user(%{
             discord_user_id: msg.author.id |> Integer.to_string(),
             username: msg.author.username <> "#" <> msg.author.discriminator,
             active: true
           }),
         {:ok, _wallet} <- Crossable.Tokenomics.create_wallet_for_user(user),
         {:ok, _avatar} <- Crossable.Avatars.create_avatar_for_user(user) do
      handle_new_user({:ok, user}, msg)
    else
      err -> handle_new_user(err, msg)
    end
  end

  def handle_new_user({:ok, _}, msg) do
    Nostrum.Api.create_message!(
      msg.channel_id,
      """
      Welcome to Crossable! You're all set!

      Available commands:
      !daily - make mindful progress on your habit and check-in!
      !wallet - view your wallet balance.
      !help - see these set of instructions again.
      """
    )
  end

  def handle_new_user({:error, reason}, msg) do
    Nostrum.Api.create_message(
      msg.channel_id,
      reason |> error_response
    )
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
