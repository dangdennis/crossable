defmodule Crossable.UserHabitsTest do
  use Crossable.DataCase

  alias Crossable.Schema.Habits.Habit

  describe "user_habits" do
    test "get_active_user_habit_by_discord_id/1" do
      {:ok, user} = Crossable.Users.create_user(%{discord_user_id: "qopriasdfa"})
      {:ok, habit} = Crossable.Repository.UserHabits.create_user_habit(%{
        user_id: user.id,
        active: true,
        habit: "swimming",
        frequency: %Postgrex.Interval{days: 1},
        })


      assert {:ok, habit} = Crossable.Repository.UserHabits.get_active_user_habit_by_discord_id(user.discord_user_id)
    end
  end
end

# get_active_user_habit_by_discord_id
