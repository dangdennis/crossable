defmodule Crossing.Commands.Attack do
  alias Crossing.Raids

  def invoke(msg) do
    case Raids.get_raid_member_by_discord_id(msg.author.id |> Integer.to_string()) do
      nil ->
        Nostrum.Api.create_message!(msg.channel_id, """
        You must join a raid to attack.
        """)

      raid_member ->
        raid = Raids.get_active_raid()

        # The dmg dealt to the raid boss = 1.0 / 3 / two-thirds of raid members.
        # This means only 2/3 of participating members need to attack the boss 3 times a week to defeat the boss.
        raidMembersCount = Enum.count(raid.raid_members)
        dmg = 1.0 / 3 / trunc(raidMembersCount * (2 / 3))

        case Raids.attacked_today?() do
          true ->
            Nostrum.Api.create_message!(msg.channel_id, """
            You've already attacked today. Loving the enthusiasm!
            """)

          false ->
            IO.inspect(dmg)
            IO.inspect(raid_member)
            IO.inspect(raid)

            {:ok, atk} =
              Raids.create_raid_attack(%{raid_id: raid.id, avatar_id: raid_member.avatar_id})

            IO.inspect(atk)
            # 4. Only allow users to attack if:
            # a. they not have done so today
            # b. raid boss completion is under 100%

            new_completion_pct = raid.completion_percentage + dmg

            case new_completion_pct >= 1.0 do
              true ->
                # 5. If attack is successful, lower the boss's health percentage accordingly. Print message to show who attacked and boss's status.
                Raids.change_raid(raid, %{completion_percentage: 1.0, active: false})
                |> Crossing.Repo.update!()

                Nostrum.Api.create_message!(msg.channel_id, """
                #{raid.raid_boss.name} has been defeated!
                """)

              false ->
                # 5. If attack is successful, lower the boss's health percentage accordingly. Print message to show who attacked and boss's status.
                Raids.change_raid(raid, %{completion_percentage: new_completion_pct})
                |> Crossing.Repo.update!()

                Nostrum.Api.create_message!(msg.channel_id, """
                #{raid.raid_boss.name}'s hp is #{
                  ((1.0 - new_completion_pct) * 100) |> Float.round()
                }%!
                """)
            end
        end
    end
  end
end
