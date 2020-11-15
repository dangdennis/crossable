defmodule Crossable.Schema.Habits.HabitLog do
  @moduledoc """
  A habit row indicates an instance of action taken (or not taken) by the user.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_habits" do
    belongs_to :habit, Crossable.Schema.Habits.Habit
    belongs_to :user, Crossable.Schema.Users.User
    field :status, :string # completed, failed, ignored?
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(habit_log, attrs) do
    habit_log
    |> cast(attrs, [:user_id, :habit_id, :status, :deleted_at])
    |> validate_required([:user_id, :habit_id, :status])
  end
end
