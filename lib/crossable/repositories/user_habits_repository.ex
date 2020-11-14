defmodule Crossable.Repository.UserHabits do
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
    query = from h in Crossable.Schema.Habits.Habit,
      join: u in Crossable.Schema.Users.User,
      on: u.discord_user_id == ^discord_id,
      where: h.active == true

    case Repo.one(query) do
      nil -> {:error, "failed to find active user habit"}
      habit -> {:ok, habit}
    end
  end
end
