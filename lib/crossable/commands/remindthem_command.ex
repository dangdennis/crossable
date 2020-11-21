defmodule Crossable.Commands.RemindThem do
  @moduledoc """
  A Discord command for developers to use and run work within Discord.
  """
  def invoke(msg) do
    if Crossable.Users.is_discord_admin?(msg.author.id |> Integer.to_string()) do
      Crossable.Habits.send_active_users_habit_reminders()
    end
  end
end
