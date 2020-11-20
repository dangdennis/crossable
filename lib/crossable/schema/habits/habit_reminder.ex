defmodule Crossable.Schema.Habits.HabitReminder do
  @moduledoc """
  The reminders sent out to users. Each reminder stores the user's response.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "habit_reminders" do
    belongs_to :user, Crossable.Schema.Users.User
    belongs_to :habit, Crossable.Schema.Habits.Habit

    # the platform's, Discord/Slack/etc, message id.
    # this links the reminder to a specific message.
    field :message_id, :string

    # the platform
    field :platform, :string

    # the user's response to the reminder
    field :response, :string
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(habit_log, attrs) do
    habit_log
    |> cast(attrs, [:user_id, :habit_id, :message_id, :platform, :response, :deleted_at])
    |> validate_required([:user_id, :habit_id, :message_id, :platform])
  end
end
