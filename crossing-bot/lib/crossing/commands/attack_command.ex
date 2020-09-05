defmodule Crossing.Commands.Attack do
  alias Crossing.Raids

  def invoke(msg) do
    # 1. get the user
    #
    # 2. get the raid, raid boss, and raid members
    #
    # 3. the dmg dealt to the raid boss = 1.0 / 3 / two-thirds of raid members.
    # This means only 2/3 of participating members need to attack the boss 3 times a week to defeat the boss.
    #
    # 4. Only allow the user to attack if their raid member status is "ready".
    #
    # 5. If attack is successful, lower the boss's health percentage accordingly. Print message to show who attacked and boss's status.
    raid = Raids.get_active_raid()
    _raid_boss = raid.raid_bosses

    Nostrum.Api.create_message!(msg.channel_id, """
    ATTTTAACCCK!
    """)
  end
end
