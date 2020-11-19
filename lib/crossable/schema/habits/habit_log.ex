defmodule Crossable.Schema.Habits.HabitLog do
  @moduledoc """
  A habit row indicates an instance of action taken (or not taken) by the user.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "habit_logs" do
    belongs_to :habit, Crossable.Schema.Habits.Habit
    belongs_to :user, Crossable.Schema.Users.User

    # indicates whether a user completed, incomplete, ignored? their habit
    field :status, :string

    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(habit_log, attrs) do
    habit_log
    |> cast(attrs, [:user_id, :habit_id, :status, :deleted_at, :inserted_at])
    |> validate_required([:user_id, :habit_id, :status])
  end
end
