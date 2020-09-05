defmodule Crossing.Consumer.MessageCreate do
  @moduledoc "Handles the `MESSAGE_CREATE` gateway event."

  alias Nostrum.Struct.Message

  @spec handle(Message.t()) :: :ok | nil
  def handle(msg) do
    unless msg.author.bot do
      Crossing.Commands.Invoker.handle(msg)
    end
  end
end
