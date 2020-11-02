defmodule Crossable.Commands.Daily do
  def invoke(msg) do
    Nostrum.Api.create_message!(msg.channel_id, """
    Daily command!
    """)
  end
end
