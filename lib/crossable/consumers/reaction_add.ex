defmodule Crossable.Consumer.MessageReactionAdd do
  @moduledoc "Handles the `MESSAGE_REACTION_ADD` gateway event."

  @doc """
  Handles all message event reactions.

  ## Examples

  ```
  reaction = %{
      channel_id: 772320950418931742,
      emoji: %{id: nil, name: "👍"},
      message_id: 777062302212947968,
      user_id: 192906671167635457
    }
  ```
  """
  @spec handle(Nostrum.Struct.Message.Reaction) :: nil
  def handle(reaction) do
    case humans_only(reaction) do
      {:human, user} ->
        # verify if the reaction is in response to a habit reminder.
        handle_habit_reminder_response(
          Crossable.Habits.get_habit_reminder_by_msg_id(
            reaction.message_id |> Integer.to_string(),
            "discord"
          ),
          reaction,
          user
        )

      {:unknown} ->
        IO.puts("bot reaction ignored")
    end
  end

  @doc """
  Only humans, not bots, beyond this point.
  User must not be a bot and exists in our world.
  """
  def humans_only(reaction) do
    case Crossable.Users.get_user_by_discord_id(reaction.user_id |> Integer.to_string()) do
      {:ok, user} -> {:human, user}
      {:error, _reason} -> {:unknown}
    end
  end

  # Handles any reactions that may be a response to a reminder question.

  def handle_habit_reminder_response({:ok, habit_reminder}, reaction, user) do
    # log whether or not the user completed their habit
    # only "👍" = completed
    # only "❌" = incomplete
    case {reaction.emoji.name, habit_reminder.response} do
      {"👍", nil} ->
        IO.puts("got a thumbs up yessss response!")

        {:ok, _entry} =
          Crossable.Habits.create_habit_log_entry(%{
            user_id: user.id,
            habit_id: habit_reminder.habit_id,
            status: "completed"
          })

        Crossable.Habits.update_habit_reminder(habit_reminder, %{response: "yes"})

      {"❌", nil} ->
        IO.puts("got a thumbs down nooooo response!")

        {:ok, _entry} =
          Crossable.Habits.create_habit_log_entry(%{
            user_id: user.id,
            habit_id: habit_reminder.habit_id,
            status: "incomplete"
          })

        Crossable.Habits.update_habit_reminder(habit_reminder, %{response: "no"})

      {_, _} ->
        IO.puts("habit response already recorded")
    end
  end
end
