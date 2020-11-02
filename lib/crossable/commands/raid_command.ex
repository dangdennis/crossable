defmodule Crossable.Commands.Raid do
  alias Crossable.Raids

  def invoke(msg) do
    case Raids.get_active_raid() do
      {:error, _} ->
        Nostrum.Api.create_message!(msg.channel_id, """
        No active raid this week.
        """)

      {:ok, raid} ->
        raid_boss = raid.raid_boss

        case raid.completion_percentage >= 1.0 do
          false ->
            Nostrum.Api.create_message!(msg.channel_id, """
            This week's raid boss is #{raid_boss.name}, HP #{
              (1 - raid.completion_percentage) * 100
            }%.

            !join to join this week's raid!
            !attack once a day to complete your goal.
            """)

          true ->
            Nostrum.Api.create_message!(msg.channel_id, """
            This week's raid boss, #{raid_boss.name}, has been defeated.

            !join to join next week's raid!
            """)
        end
    end
  end
end
