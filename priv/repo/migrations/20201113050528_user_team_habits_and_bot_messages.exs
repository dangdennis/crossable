defmodule Crossable.Repo.Migrations.UserHabits do
  use Ecto.Migration

  def change do
    # USER HABITS
    create table(:user_habits) do
      add :habit, :string
      add :active, :boolean
      # Rely on Postgres's interval type
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

    # TEAM HABITS
    # TODO

    # DISCORD MESSAGES
    create table(:discord_messages) do
      add :recipient_id, :integer
      add :sender_id, :integer
      add :is_bot, :boolean
      add :message, :string
      add :deleted_at, :utc_datetime

      timestamps()
    end

    # HABIT_LOGS
    create table(:habit_logs) do
      add :user_id, references(:users)
      add :habit_id, references(:user_habits)
      add :completed, :boolean

      timestamps()
    end

  end
end
