defmodule Crossable.Commands.Balance do
  def invoke(msg) do
    # find the discord user
    # find their wallet
    # DM their balance
    Nostrum.Api.create_message!(msg.channel_id, """
    Your total token balance so far is
    """)
  end
end
