defmodule Crossable.Habits do
  @moduledoc """
  The Habits context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo
  alias Crossable.Schema.Habits.HabitReminder

  def create_user_habit(attrs \\ %{}) do
    %Crossable.Schema.Habits.Habit{}
    |> Crossable.Schema.Habits.Habit.changeset(attrs)
    |> Repo.insert()
  end

  def create_habit_reminder(attrs \\ %{}) do
    %HabitReminder{}
    |> HabitReminder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a habit reminder.

  ## Examples

      iex> update_habit_reminder(reminder, %{field: new_value})
      {:ok, %HabitReminder{}}

      iex> update_habit_reminder(reminder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_habit_reminder(%HabitReminder{} = reminder, attrs) do
    reminder
    |> HabitReminder.changeset(attrs)
    |> Repo.update()
  end

  def create_habit_log_entry(attrs \\ %{}) do
    %Crossable.Schema.Habits.HabitLog{}
    |> Crossable.Schema.Habits.HabitLog.changeset(attrs)
    |> Repo.insert()
  end

  def get_habit_reminder_by_msg_id(message_id, "discord") do
    query =
      from hr in HabitReminder,
        where: hr.message_id == ^message_id and hr.platform == "discord"

    case Repo.one(query) do
      nil -> {:error, "failed to find user"}
      user -> {:ok, user}
    end
  end

  @doc """
  Returns the list of avatars.

  ## Examples

      iex> get_active_user_habit_by_discord_id("481092341324")
      [:ok, %Crossable.Schema.UserHabit]

  """
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

  @doc """
  Sends a habit reminder to a Discord user.

  ## Examples

      iex>send_reminder("1093481209")
      {:ok, _}
  """
  def send_reminder(discord_user_id) do
    IO.puts("""
    attempt to send reminder to discord user #{discord_user_id}
    """)

    # retrieve the user's current habit
    {:ok, user_habit} = get_active_user_habit_by_discord_id(discord_user_id)

    {:ok, dm_channel} = Nostrum.Api.create_dm(discord_user_id |> String.to_integer())

    msg =
      Nostrum.Api.create_message!(dm_channel.id, """
      Daily check-in! Did you complete your individual habit, #{user_habit.habit}?
      """)

    {:ok} = set_reminder_reactions(dm_channel.id, msg.id)

    {:ok, user} = Crossable.Users.get_user_by_discord_id(discord_user_id)

    # Sent out a reminder to the user that expects a response.
    # The user can respond by reacting to the question.
    {:ok, _} =
      create_habit_reminder(%{
        user_id: user.id,
        habit_id: user_habit.id,
        message_id: msg.id |> Integer.to_string(),
        platform: "discord"
      })

    # Log all bot messages
    {:ok, _} =
      Crossable.Messages.create_discord_message(%{
        recipient_id: user.id,
        is_bot: true,
        message_id: msg.id |> Integer.to_string(),
        content: msg.content
      })

    IO.puts("""
    successfully sent reminder to discord user #{discord_user_id}
    """)
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
    IO.puts(Ecto.Adapters.SQL.to_sql(:all, Repo, queryable))
    queryable
  end
end
