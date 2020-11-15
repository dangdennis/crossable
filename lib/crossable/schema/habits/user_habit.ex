defmodule Crossable.Schema.Habits.Habit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_habits" do
    field :habit, :string # habit name
    field :active, :boolean # determines whether the habit is currently active and in-training
    belongs_to :user, Crossable.Schema.Users.User

    # Relies on Postgres's interval type.
    # How often the user expects to complete the habit.
    # field :frequency, Postgrex.Interval

    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:user_id, :habit, :active, :deleted_at])
    |> validate_required([:user_id, :habit, :active])
    |> unique_constraint([:user_id, :habit], name: :users_user_id_habit_index)
  end
end
