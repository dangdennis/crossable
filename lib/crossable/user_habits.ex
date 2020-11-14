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
      Crossable.Habits.get_active_user_habit_by_discord_id(
        discord_user_id
        |> Integer.to_string()
      )

    # get their team habit

    dm_channel = Nostrum.Api.create_dm!(discord_user_id)

    msg =
      Nostrum.Api.create_message!(dm_channel.id, """
      Daily check-in! Did you complete your individual habit, #{user_habit.habit}?
      """)

    IO.inspect(msg)

    Nostrum.Api.create_reaction(dm_channel.id, msg.id, "👍")
    :timer.sleep(500)
    Nostrum.Api.create_reaction(dm_channel.id, msg.id, "❌")

    {:ok, user} =
      Crossable.Users.get_user_by_discord_id(
        discord_user_id
        |> Integer.to_string()
      )

    Crossable.Messages.create_discord_message(%{
      recipient_id: user.id,
      is_bot: true,
      message_id: msg.id,
      content: msg.content
    })
  end

  def print_sql(queryable) do
    IO.inspect(Ecto.Adapters.SQL.to_sql(:all, Repo, queryable))
    queryable
  end
end
