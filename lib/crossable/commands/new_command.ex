defmodule Crossable.Commands.New do
  alias Crossable.Users

  def handle(msg) do
    case Users.create_user(%{
           discord_user_id: msg.author.id |> Integer.to_string(),
           avatar: %{}
         }) do
      {:ok, _user} ->
        Nostrum.Api.create_message(
          msg.channel_id,
          """
          Welcome to Crossable! You're all set!

          Available commands:
          !daily - make mindful progress on your habit and check-in!
          !wallet - view your wallet balance.
          !help - see these set of instructions again.
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
