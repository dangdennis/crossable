defmodule Crossing.Commands.Join do
  alias Crossing.Raids

  def invoke(msg) do
    # raid = Raids.get_active_raid()
    # raid_boss = raid.raid_boss

    # 1 Find the user's avatar
    # 2 Find the active raid of the week
    # 3 If the raid hasn't ended yet and it's not 48 hours past the start date, add the user's avatar to the raid as a raid member

    Nostrum.Api.create_message!(msg.channel_id, """
    You've joined this week's raid!
    """)
  end
end
