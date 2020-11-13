defmodule Crossable.Habits.UserHabit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_habits" do
    field :habit, :string
    field :active, :string
    field :frequency, :string
    field :deleted_at, :utc_datetime
    belongs_to :user, Crossable.Users.User

    timestamps()
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:user_id, :habit, :active, :frequency, :deleted_at])
    |> validate_required([:user_id, :habit, :active, :frequency])
    |> unique_constraint([:user_id, :habit], name: :users_user_id_habit_index)
  end
end
