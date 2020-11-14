defmodule Crossable.Commands.RemindMe do
  def invoke(msg) do
    Crossable.Habits.send_reminder(msg.author.id)
  end
end
