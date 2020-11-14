defmodule Crossable.Consumer.MessageReactionAdd do
  @moduledoc "Handles the `MESSAGE_REACTION_ADD` gateway event."

  @spec handle(Nostrum.Struct.Message.Reaction) :: nil
  def handle(reaction) do
    IO.inspect(reaction)
    # reaction
    # %{
    #   channel_id: 772320950418931742,
    #   emoji: %{id: nil, name: "👍"},
    #   message_id: 777062302212947968,
    #   user_id: 192906671167635457
    # }

    # verify if the message exists in the discord_msg logs
    # if it exists, it means the bot sent out a reminder question
    # log whether or not the user completed their habit
    # only "👍" = completed
    # only "❌" = incomplete
  end
end
