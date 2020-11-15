# Configure Oban workers in `config.exs`

defmodule Crossable.Workers.Notification.DailyHabit do
  @moduledoc """
  Sends daily habit reminders to all active users.
  """

  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{}}) do
    # query for all active users, and send them a reminder
    Crossable.Users.list_active_users()
    |> Enum.each(fn user ->
      Crossable.Habits.send_reminder(user.discord_user_id)
    end)

    :ok
  end
end

defmodule Crossable.Workers.Notification.DailyRaid do
  @moduledoc """
  Sends daily reminders to engage raid members.
  """

  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{}}) do
    Nostrum.Api.create_message!(747_154_772_561_363_025, """
    Daily check-in! When you hit your goal today, deal damage to the raid boss!
    """)

    :ok
  end
end
