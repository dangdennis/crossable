defmodule Crossable.Commands.RemindMe do
  def invoke(msg) do
    Crossable.Habits.send_reminder(msg.author.id |> Integer.to_string())
  end
end
