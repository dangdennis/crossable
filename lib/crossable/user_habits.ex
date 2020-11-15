defmodule Crossable.Habits do
  @moduledoc """
  The UserHabits context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo

  def create_user_habit(attrs \\ %{}) do
    %Crossable.Schema.Habits.Habit{}
    |> Crossable.Schema.Habits.Habit.changeset(attrs)
    |> Repo.insert()
  end

  def create_habit_reminder(attrs \\ %{}) do
    %Crossable.Schema.Habits.HabitReminder{}
    |> Crossable.Schema.Habits.HabitReminder.changeset(attrs)
    |> Repo.insert()
  end

  def get_active_user_habit_by_discord_id(discord_id) do
    query =
      from h in Crossable.Schema.Habits.Habit,
        join: u in Crossable.Schema.Users.User,
        on: u.id == h.user_id,
        where: h.active == true,
        where: u.discord_user_id == ^discord_id

    case Repo.one(query) do
      nil -> {:error, "failed to find active user habit"}
      habit -> {:ok, habit}
    end
  end

  def send_reminder(discord_user_id) do
    # retrieve the user's current habit
    {:ok, user_habit} =
      get_active_user_habit_by_discord_id(
        discord_user_id
        |> Integer.to_string()
      )

    dm_channel = Nostrum.Api.create_dm!(discord_user_id)

    msg =
      Nostrum.Api.create_message!(dm_channel.id, """
      Daily check-in! Did you complete your individual habit, #{user_habit.habit}?
      """)

    IO.inspect(msg)

    {:ok} = set_reminder_reactions(dm_channel.id, msg.id)

    {:ok, user} =
      Crossable.Users.get_user_by_discord_id(
        discord_user_id
        |> Integer.to_string()
      )

    {:ok, _} =
      create_habit_reminder(%{
        user_id: user.id,
        habit_id: user_habit.id,
        message_id: msg.id |> Integer.to_string(),
        platform: "discord"
      })

    Crossable.Messages.create_discord_message(%{
      recipient_id: user.id,
      is_bot: true,
      message_id: msg.id |> Integer.to_string(),
      content: msg.content
    })
  end

  def set_reminder_reactions(channel_id, msg_id) do
    with {:ok} <- Nostrum.Api.create_reaction(channel_id, msg_id, "👍"),
         :timer.sleep(500),
         {:ok} <- Nostrum.Api.create_reaction(channel_id, msg_id, "❌") do
      {:ok}
    else
      err -> {:error, err}
    end
  end

  def print_sql(queryable) do
    IO.inspect(Ecto.Adapters.SQL.to_sql(:all, Repo, queryable))
    queryable
  end
end
