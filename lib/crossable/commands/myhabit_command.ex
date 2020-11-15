defmodule Crossable.Commands.MyHabit do
  def invoke(msg) do
    # retrieve the user's current habit
    Crossable.Habits.get_active_user_habit_by_discord_id(
      msg.author.id
      |> Integer.to_string()
    )
    |> handle_active_habit(msg.author.id)
  end

  def handle_active_habit({:ok, user_habit}, author_id) do
    dm_channel = Nostrum.Api.create_dm!(author_id)

    Nostrum.Api.create_message!(dm_channel.id, """
    Your habit is #{user_habit.habit}.
    """)
  end

  def handle_active_habit({:error, _reason}, author_id) do
    dm_channel = Nostrum.Api.create_dm!(author_id)

    Nostrum.Api.create_message!(dm_channel.id, """
    You do not have an active habit.
    """)
  end
end
