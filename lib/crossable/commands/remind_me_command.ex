defmodule Crossable.Commands.RemindMe do
  def invoke(msg) do
    Crossable.Services.UserHabit.send_reminder(msg.author.id)
  end
end
