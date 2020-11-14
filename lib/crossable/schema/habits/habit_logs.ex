defmodule Crossable.Schema.Habits.HabitLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_habits" do
    field :completed, :boolean
    field :deleted_at, :utc_datetime
    belongs_to :habit, Crossable.Schema.Habits.Habit
    belongs_to :user, Crossable.Schema.Users.User

    timestamps()
  end

  @doc false
  def changeset(habit_log, attrs) do
    habit_log
    |> cast(attrs, [:user_id, :habit_id, :active, :deleted_at])
    |> validate_required([:user_id, :habit_id, :active])
  end
end
