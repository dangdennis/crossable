defmodule Crossable.Commands.Join do
  def invoke(msg) do
    # get the msg's author's channel
    dm_channel = Nostrum.Api.create_dm!(msg.author.id)

    # add default dialog flow 1 to the channel
    case Crossable.Dialogs.assign_dialog_flow_to_channel(dm_channel.id |> Integer.to_string(), 1) do
      {:ok, _channel_dialog_flow} ->
        Nostrum.Api.create_message!(dm_channel.id, """
        You're on for a 30-day treat!
        """)

      {:error, _reason} ->
        Nostrum.Api.create_message!(dm_channel.id, """
        You're already participating.
        """)
    end
  end
end
