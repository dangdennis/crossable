defmodule Crossable.Commands.Wallet do
  def invoke(msg) do
    Nostrum.Api.create_message!(msg.channel_id, """
    Wallet command!
    """)
  end
end
