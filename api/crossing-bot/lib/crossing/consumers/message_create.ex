defmodule Crossing.Consumer.MessageCreate do
  @moduledoc "Handles the `MESSAGE_CREATE` gateway event."

  alias Nostrum.Struct.Message

  @spec handle(Message.t()) :: :ok | nil
  def handle(msg) do
    unless msg.author.bot do
      case msg.content do
        "!new" ->
          IO.inspect(msg)

          Nostrum.Api.create_message(
            msg.channel_id,
            "Welome to Health Crossing! Setting up your account real quick..."
          )

          :timer.sleep(1500)

          Nostrum.Api.create_message(
            msg.channel_id,
            "All done!"
          )

        _ ->
          IO.inspect(msg)
      end
    end
  end
end
