defmodule Crossable.Commands.Balance do
  def invoke(msg) do
    # find the discord user
    # find their wallet
    # DM their balance
    dm_channel = Nostrum.Api.create_dm!(msg.author.id)

    Nostrum.Api.create_message!(dm_channel.id, """
    Your total token balance so far is
    """)
  end
end
