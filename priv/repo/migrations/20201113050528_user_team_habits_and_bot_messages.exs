defmodule Crossable.Repo.Migrations.UserHabits do
  use Ecto.Migration

  def change do
    # USER HABITS
    create table(:user_habits) do
      add :habit, :string
      add :active, :boolean

      # Relies on Postgres's interval type.
      # How often the user expects to complete the habit.
      add :frequency, :interval

      add :user_id, references(:users)
      add :deleted_at, :utc_datetime

      timestamps()
    end

    create unique_index(:user_habits, [:user_id, :habit], name: :users_user_id_habit_index)

    alter table(:user_habits) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    # DISCORD MESSAGES
    create table(:discord_messages) do
      add :recipient_id, references(:users)
      add :sender_id, references(:users)
      add :message_id, :string
      add :is_bot, :boolean
      add :content, :string
      add :deleted_at, :utc_datetime

      timestamps()
    end

    # HABIT REMINDERS
    create table(:habit_reminders) do
      add :user_id, references(:users)
      add :habit_id, references(:user_habits)
      add :message_id, :string # the plaform's, Discord/Slack/etc, message id
      add :platform, :string # the platform
      add :response, :string # the user's response to the reminder
      add :deleted_at, :utc_datetime

      timestamps()
    end

    # HABIT_LOGS
    create table(:habit_logs) do
      add :user_id, references(:users)
      add :habit_id, references(:user_habits)
      add :status, :string

      timestamps()
    end

  end
end
