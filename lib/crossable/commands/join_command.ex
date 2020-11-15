defmodule Crossable.Commands.Join do
  alias Crossable.Raids
  alias Crossable.Avatars

  def invoke(msg) do
    # case Raids.get_active_raid() do
    #   {:error, _} ->
    #     Nostrum.Api.create_message!(msg.channel_id, """
    #     There's no active raid.
    #     """)

    #   {:ok, raid} ->
    #     avatar = Avatars.get_by_discord_id(msg.author.id |> Integer.to_string())

    #     # 3 If the raid hasn't ended yet and it's not 48 hours past the start date, add the user's avatar to the raid as a raid member
    #     day_diff = DateTime.diff(Timex.now(), raid.start_time, :second) / 60 / 60

    #     case day_diff > 48 do
    #       true ->
    #         Nostrum.Api.create_message!(msg.channel_id, """
    #         The raid has already started 48 hours ago. Come join again next week.
    #         """)

    #       false ->
    #         case Crossable.Raids.create_raid_member(%{
    #                avatar_id: avatar.id,
    #                raid_id: raid.id,
    #                status: "ready"
    #              }) do
    #           {:ok, _avatar} ->
    #             Nostrum.Api.create_message!(msg.channel_id, """
    #             You've joined this week's raid!
    #             """)

    #           {:error, _changeset} ->
    #             Nostrum.Api.create_message!(msg.channel_id, """
    #             You've already joined this week's raid!
    #             """)
    #         end
    #     end
    # end
  end
end
