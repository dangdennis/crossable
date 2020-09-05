defmodule Crossing.Commands.Raid do
  alias Crossing.Raids

  def invoke(msg) do
    raid = Raids.get_active_raid()
    raid_boss = raid.raid_boss

    Nostrum.Api.create_message!(msg.channel_id, """
    This week's raid boss is #{raid_boss.name}, remaining hp #{
      (1 - raid.completion_percentage) * 100
    }.

    !join to join this week's raid!
    !attack once a day to complete your goal.
    """)
  end
end
