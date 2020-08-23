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
                Welome to Health Crossing! You're all set!

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
              # read_error(message)

              IO.inspect(message.errors)

              IO.puts(
                Enum.reduce(message.errors, "", fn error, acc ->
                  acc <> error.username
                end)
              )

              Nostrum.Api.create_message(
                msg.channel_id,
                """
                You already registered.
                """
              )
          end

        _ ->
          # IO.inspect(msg)
          nil
      end
    end
  end

  defp read_error(errors) do
    Enum.map(errors, fn error ->
      IO.inspect(error.name)
      IO.inspect(error.types)
    end)
  end
end
