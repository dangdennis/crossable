defmodule Crossable.Commands.RemindMe do
  def invoke(msg) do
    {:ok, user} = Crossable.Users.get_user_by_discord_id(msg.author.id |> Integer.to_string())

    if Crossable.Users.is_admin?(user.id) do
      Crossable.Habits.send_reminder(msg.author.id |> Integer.to_string())
    end
  end
end
