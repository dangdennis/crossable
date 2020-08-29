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
                !update - starts a new form to update your personal goals
                !status - get a list of your avatar's health stats
                !share - share your stats in the general channel and get some social media links

                Dangerous commands:
                !bomb - deletes all your data, including your avatar and your health stats
                """
              )

              IO.inspect(user)

            {:error, message} ->
              Nostrum.Api.create_message(
                msg.channel_id,
                message.errors |> read_error |> Enum.join(" ")
              )
          end

        _ ->
          nil
      end
    end
  end

  defp read_error(errors) do
    Enum.map(errors, fn error ->
      case error do
        {:username, _msg} ->
          "Your username is already registered."

        _ ->
          "Something went wrong."
      end
    end)
  end
end
