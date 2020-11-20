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
      add :content, :string
      add :discord_msg_id, :string
      add :is_bot, :boolean
      timestamps()
      add :deleted_at, :utc_datetime
    end

    create unique_index(:discord_messages, [:discord_msg_id], name: :discord_messages_discord_msg_id_index)

    alter table(:discord_messages) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    # HABIT REMINDERS
    create table(:habit_reminders) do
      add :user_id, references(:users)
      add :habit_id, references(:user_habits)
      add :response, :string # the user's response to the reminder
      add :message_id, :string # the plaform's, Discord/Slack/etc, message id
      add :platform, :string # the platform
      timestamps()
      add :deleted_at, :utc_datetime
    end

    create unique_index(:habit_reminders, [:message_id, :platform], name: :discord_messages_message_id_platform_index)

    alter table(:habit_reminders) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

    # HABIT_LOGS
    create table(:habit_logs) do
      add :user_id, references(:users)
      add :habit_id, references(:user_habits)
      add :status, :string
      timestamps()
      add :deleted_at, :utc_datetime
    end

    alter table(:habit_logs) do
      modify(:inserted_at, :timestamp, default: fragment("NOW()"))
      modify(:updated_at, :timestamp, default: fragment("NOW()"))
    end

  end
end
