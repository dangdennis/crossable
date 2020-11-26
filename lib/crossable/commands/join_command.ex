defmodule Crossable.Commands.Join do
  def invoke(msg) do
    # get the msg's author's channel
    dm_channel = Nostrum.Api.create_dm!(msg.author_id)



    # add default dialog flow 1 to the channel
    # if existing, tell them they're already participating
    # if new, tell them they're now participating

  end
end
