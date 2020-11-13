defmodule Crossable.Services.Habit.Reminder do
  def send_reminder(_to_user_id) do
    # retrieve the user's current habit
    # get their individual habit
    # get their team habit
    # log the outbound messages, ensuring each message is thumbed up and down once
    Nostrum.Api.create_message!(747_154_772_561_363_025, """
    Daily check-in! When you hit your goal today, deal damage to the raid boss!
    """)
  end
end
