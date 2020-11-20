defmodule Crossable.Commands.RemindMe do
  def invoke(msg) do
    if Crossable.Users.is_discord_admin?(msg.author.id |> Integer.to_string()) do
      Crossable.Habits.send_reminder(msg.author.id |> Integer.to_string())
    end
  end
end
