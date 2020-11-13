defmodule Crossable.Services.UserHabit do
  def send_reminder(discord_user_id) do
    # retrieve the user's current habit
    {:ok, user_habit} =
      Crossable.Repository.UserHabits.get_active_user_habit_by_discord_id(
        discord_user_id
        |> Integer.to_string()
      )

    # get their team habit

    dm_channel = Nostrum.Api.create_dm!(discord_user_id)

    msg =
      Nostrum.Api.create_message!(dm_channel.id, """
      Daily check-in! Did you complete your individual habit, #{user_habit.habit}?
      """)

    Nostrum.Api.create_reaction!(dm_channel.id, msg.id, "👍")
    :timer.sleep(500)
    Nostrum.Api.create_reaction!(dm_channel.id, msg.id, "❌")
  end
end
