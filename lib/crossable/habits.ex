defmodule Crossable.Habits do
  @moduledoc """
  The Habits context.
  """

  require Logger

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
      nil -> {:error, "failed to find habit reminder"}
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
  Sends habit reminders to all active users if it's after 6PM their time zone

  """
  def send_active_users_habit_reminders() do
    Crossable.Users.list_active_users()
    |> Enum.each(fn user ->
      {:ok, user_current_dt} =
        DateTime.now(user.time_zone || "America/New_York", Tzdata.TimeZoneDatabase)

      Crossable.Time.run_once_within_hour(DateTime.to_time(user_current_dt), ~T[18:00:00], fn ->
        spawn(fn -> send_reminder(user.discord_user_id) end)
      end)
    end)
  end

  @doc """
  Sends a habit reminder to a Discord user.

  ## Examples

      iex>send_reminder("1093481209")
      {:ok, _}
  """
  def send_reminder(discord_user_id) do
    Logger.info("""
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
        discord_msg_id: msg.id |> Integer.to_string(),
        content: msg.content
      })

    Logger.info("""
    successfully sent reminder to discord user #{discord_user_id}
    """)
  end

  @doc """
  Sets the thumbs-up and thumbs-down emoji on a Discord message.
  """
  def set_reminder_reactions(channel_id, msg_id) do
    with {:ok} <- Nostrum.Api.create_reaction(channel_id, msg_id, "👍"),
         :timer.sleep(500),
         {:ok} <- Nostrum.Api.create_reaction(channel_id, msg_id, "❌") do
      {:ok}
    else
      err -> {:error, err}
    end
  end

  @doc """
  Returns the number of habit log streaks belonging to a user for a given range of days

  ## Examples

      iex>get_habit_streak(1, 7)
      3 # number of entries in a streak

  """
  @spec get_habit_streak(integer(), integer()) :: integer
  def get_habit_streak(user_id, num_days_prev) do
    # query for a number of habit_logs in the past number of days
    start_date = Date.utc_today()
    end_date = Date.add(start_date, -num_days_prev)

    from(hl in Crossable.Schema.Habits.HabitLog,
      where: fragment("?::date", hl.inserted_at) <= ^start_date,
      where: fragment("?::date", hl.inserted_at) >= ^end_date,
      where: hl.user_id == ^user_id
    )
    |> Repo.all()
    |> length()
  end
end
