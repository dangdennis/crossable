defmodule Crossing.Commands.Attack do
  alias Crossing.Raids

  def invoke(msg) do
    # 1. get the raid member
    case Raids.get_raid_member_by_discord_id(msg.author.id |> Integer.to_string()) do
      nil ->
        Nostrum.Api.create_message!(msg.channel_id, """
        You must join this raid to attack.
        """)

      raid_member ->
        #
        # 2. get the raid, raid boss, and raid members
        raid = Raids.get_active_raid()

        #
        # 3. the dmg dealt to the raid boss = 1.0 / 3 / two-thirds of raid members.
        # This means only 2/3 of participating members need to attack the boss 3 times a week to defeat the boss.
        raidMembersCount = Enum.count(raid.raid_members)
        dmg = 1.0 / 3 / trunc(raidMembersCount * (2 / 3))

        IO.inspect(dmg)

        #
        # 4. Only allow the user to attack if their raid member status is "ready".
        #
        # 5. If attack is successful, lower the boss's health percentage accordingly. Print message to show who attacked and boss's status.

        IO.inspect(raid)

        Nostrum.Api.create_message!(msg.channel_id, """
        ATTTTAACCCK!
        """)
    end
  end
end
