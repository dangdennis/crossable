defmodule Crossable.Commands.Help do
  def invoke(msg) do
    Nostrum.Api.create_message!(msg.channel_id, """
    Available commands:
    !daily - make mindful progress on your habit and check-in!
    !wallet - view your wallet balance.
    !help - get a list of all available commands
    """)
  end
end
