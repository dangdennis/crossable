defmodule Crossable.Commands.Attack do
  # alias Crossable.Raids

  def invoke(_msg) do
    # case Raids.get_active_raid() do
    #   {:error, _} ->
    #     Nostrum.Api.create_message!(msg.channel_id, """
    #     There's no active raid.
    #     """)

    #   {:ok, raid} ->
    #     case Raids.get_raid_member_by_discord_id(msg.author.id |> Integer.to_string(), raid.id) do
    #       nil ->
    #         Nostrum.Api.create_message!(msg.channel_id, """
    #         You must join a raid to attack.
    #         """)

    #       raid_member ->
    #         # The dmg dealt to the raid boss = 1.0 / 3 / two-thirds of raid members.
    #         # This means only 2/3 of participating members need to attack the boss 3 times a week to defeat the boss.
    #         raidMembersCount = Enum.count(raid.raid_members)

    #         dmg =
    #           case raidMembersCount <= 1 do
    #             true ->
    #               1.0 / 3

    #             false ->
    #               1.0 / 3 / trunc(raidMembersCount * (2 / 3))
    #           end

    #         case Raids.attacked_today?(raid_member) do
    #           true ->
    #             Nostrum.Api.create_message!(msg.channel_id, """
    #             You've already attacked today. Loving the enthusiasm!
    #             """)

    #           false ->
    #             {:ok, _atk} =
    #               Raids.create_raid_attack(%{raid_id: raid.id, raid_member_id: raid_member.id})

    #             # 4. Only allow users to attack if:
    #             # a. they not have done so today
    #             # b. raid boss completion is under 100%

    #             new_completion_pct = raid.completion_percentage + dmg

    #             # 5. If attack is successful, lower the boss's health percentage accordingly. Print message to show who attacked and boss's status.
    #             # Cap the raid completion to 100%
    #             case {new_completion_pct >= 1.0, raid.active} do
    #               {true, true} ->
    #                 Raids.change_raid(raid, %{completion_percentage: 1.0, active: false})
    #                 |> Crossable.Repo.update!()

    #                 Nostrum.Api.create_message!(msg.channel_id, """
    #                 #{msg.author.username}##{msg.author.discriminator} lands the finishing blow on #{
    #                   raid.raid_boss.name
    #                 }!

    #                 #{raid.raid_boss.image_url}
    #                 """)

    #               {true, false} ->
    #                 Nostrum.Api.create_message!(msg.channel_id, """
    #                 #{raid.raid_boss.name} has already been defeated!
    #                 """)

    #               {false, _active} ->
    #                 Raids.change_raid(raid, %{completion_percentage: new_completion_pct})
    #                 |> Crossable.Repo.update!()

    #                 Nostrum.Api.create_message!(msg.channel_id, """
    #                 #{raid.raid_boss.name}'s HP dropped to #{
    #                   ((1.0 - new_completion_pct) * 100) |> Float.round()
    #                 }%!
    #                 """)
    #             end
    #         end
    #     end
    # end
  end
end
