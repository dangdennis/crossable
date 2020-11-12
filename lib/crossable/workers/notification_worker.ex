defmodule Crossable.Workers.Notification.DailyHabit do
  use Oban.Worker, queue: :events

  alias Crossing.Users

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{}}) do
    users =

    Nostrum.Api.create_message!(747_154_772_561_363_025, """
    Daily check-in! When you hit your goal today, deal damage to the raid boss!
    """)

    :ok
  end
end

defmodule Crossable.Workers.Notification.DailyRaid do
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{}}) do
    Nostrum.Api.create_message!(747_154_772_561_363_025, """
    Daily check-in! When you hit your goal today, deal damage to the raid boss!
    """)

    :ok
  end
end
