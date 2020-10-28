defmodule Crossing.Commands.Help do
  def invoke(msg) do
    Nostrum.Api.create_message!(msg.channel_id, """
    Available commands:
    !new - registers your account onto Crossing
    !raid - learn what raid is happening this week
    !join - to join the week's raid
    !attack - confirm that you've completed your daily task, and deal some damage to the raid boss!
    !help - get a list of all available commands

    Real serious commands:
    !bomb - deletes all your data
    """)
  end
end
