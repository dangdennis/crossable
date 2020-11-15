defmodule Crossable.Commands.Help do
  def invoke(msg) do
    Nostrum.Api.create_message!(msg.channel_id, """
    Available commands:
    !myhabit - sometimes you forget what're working on. we get it!
    !balance - view your wallet balance.
    !help - get a list of all available commands
    """)
  end
end
