defmodule Crossable.HabitsTest do
  use Crossable.DataCase

  describe "Crossable.Habits.create_user_habit/1" do
    test "successfully create a user habit with valid args" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      assert {:ok, _} =
               Crossable.Habits.create_user_habit(%{
                 habit: "swimming",
                 active: true,
                 user_id: user.id
               })
    end

    test "fails to create a user habit with invalid args" do
      assert {:error, _} =
               Crossable.Habits.create_user_habit(%{
                 habit: "swimming",
                 active: nil,
                 user_id: nil
               })
    end
  end

  describe "Crossable.Habits.create_habit_log_entry/1" do
    test "successfully create a user habit with valid args" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      {:ok, habit} =
        Crossable.Habits.create_user_habit(%{
          habit: "swimming",
          active: true,
          user_id: user.id
        })

      assert {:ok, _} =
               Crossable.Habits.create_habit_log_entry(%{
                 habit_id: habit.id,
                 user_id: user.id,
                 status: "completed"
               })
    end

    test "fails to create a user habit with invalid args" do
      assert {:error, _} =
               Crossable.Habits.create_habit_log_entry(%{
                 habit: "swimming",
                 active: nil,
                 user_id: nil
               })
    end
  end

  describe "Crossable.Habits.create_habit_reminder/1" do
    test "successfully create a habit reminder with valid args" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      {:ok, user_habit} =
        Crossable.Habits.create_user_habit(%{
          habit: "swimming",
          active: true,
          user_id: user.id
        })

      assert {:ok, _} =
               Crossable.Habits.create_habit_reminder(%{
                 user_id: user.id,
                 habit_id: user_habit.id,
                 message_id: "12348109480",
                 platform: "discord"
               })
    end

    test "fails to create a habit reminder with invalid args" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      {:ok, _user_habit} =
        Crossable.Habits.create_user_habit(%{
          habit: "swimming",
          active: true,
          user_id: user.id
        })

      assert {:error, _} =
               Crossable.Habits.create_habit_reminder(%{
                 user_id: nil,
                 habit_id: nil,
                 message_id: nil,
                 platform: nil
               })
    end
  end

  describe "Crossable.Habits.get_active_user_habit_by_discord_id/1" do
    test "get the user's single active habit" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      {:ok, _habit} =
        Crossable.Habits.create_user_habit(%{
          user_id: user.id,
          active: true,
          habit: "swimming",
          frequency: %Postgrex.Interval{days: 1}
        })

      assert {:ok, _habit} =
               Crossable.Habits.get_active_user_habit_by_discord_id(user.discord_user_id)
    end

    test "get the user's single active habit among their other inactive habits" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      {:ok, _habit1} =
        Crossable.Habits.create_user_habit(%{
          user_id: user.id,
          active: true,
          habit: "swimming",
          frequency: %Postgrex.Interval{days: 1}
        })

      {:ok, _habit2} =
        Crossable.Habits.create_user_habit(%{
          user_id: user.id,
          active: false,
          habit: "dance",
          frequency: %Postgrex.Interval{days: 1}
        })

      assert {:ok, _habit1} =
               Crossable.Habits.get_active_user_habit_by_discord_id(user.discord_user_id)
    end
  end

  describe "Crossable.Habits.get_habit_reminder_by_msg_id/2" do
    test "successfully queries for the habit_reminder by msg_id and discord" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      {:ok, user_habit} =
        Crossable.Habits.create_user_habit(%{
          habit: "swimming",
          active: true,
          user_id: user.id
        })

      msg_id = 13_412_342_435_243

      {:ok, _habit_reminder} =
        Crossable.Habits.create_habit_reminder(%{
          user_id: user.id,
          habit_id: user_habit.id,
          message_id: msg_id |> Integer.to_string(),
          platform: "discord"
        })

      assert {:ok, _} =
               Crossable.Habits.get_habit_reminder_by_msg_id(
                 msg_id |> Integer.to_string(),
                 "discord"
               )
    end
  end

  describe "Crossable.Habits.get_habit_streak/2" do
    test "returns a working streak" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})

      {:ok, user_habit} =
        Crossable.Habits.create_user_habit(%{
          habit: "swimming",
          active: true,
          user_id: user.id
        })

      {:ok, _} =
        Crossable.Habits.create_habit_log_entry(%{
          habit_id: user_habit.id,
          user_id: user.id,
          status: "complete"
        })

      {:ok, _} =
        Crossable.Habits.create_habit_log_entry(%{
          habit_id: user_habit.id,
          user_id: user.id,
          status: "complete"
        })

      {:ok, _} =
        Crossable.Habits.create_habit_log_entry(%{
          habit_id: user_habit.id,
          user_id: user.id,
          status: "complete"
        })

      3 = Crossable.Habits.get_habit_streak(user.id, 1)
    end
  end
end
