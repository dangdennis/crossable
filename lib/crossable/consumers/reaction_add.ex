defmodule Crossable.Consumer.MessageReactionAdd do
  @moduledoc "Handles the `MESSAGE_REACTION_ADD` gateway event."
  require Logger

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
        Logger.info("bot reaction ignored")
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
        Logger.info("got a thumbs up yessss response!")

        {:ok, _entry} =
          Crossable.Habits.create_habit_log_entry(%{
            user_id: user.id,
            habit_id: habit_reminder.habit_id,
            status: "completed"
          })

        Crossable.Habits.update_habit_reminder(habit_reminder, %{response: "yes"})
        Nostrum.Api.create_message!(reaction.channel_id, "Nice job!")
        award_tokens_with_streaks(user)

      {"❌", nil} ->
        Logger.info("got a thumbs down nooooo response!")

        {:ok, _entry} =
          Crossable.Habits.create_habit_log_entry(%{
            user_id: user.id,
            habit_id: habit_reminder.habit_id,
            status: "incomplete"
          })

        Crossable.Habits.update_habit_reminder(habit_reminder, %{response: "no"})
        Nostrum.Api.create_message!(reaction.channel_id, "Gotcha!")
        {:ok, _} = Crossable.Tokenomics.award_tokens(user, 1)

      {_, _} ->
        Logger.info("habit response already recorded")
    end
  end

  def handle_habit_reminder_response({:error, reason}, _reaction, user) do
    Logger.error(reason <> " for user id" <> (user.id |> Integer.to_string()))
  end

  @spec award_tokens_with_streaks(Crossable.Schema.Users.User.t()) ::
          {:ok, Crossable.Schema.Tokenomics.Wallet.t()}
  def award_tokens_with_streaks(user) do
    # query the user's habit logs for streaks
    # first check for a 30-day streak
    case Crossable.Habits.get_habit_streak(user.id, 30) do
      30 ->
        {:ok, _} = Crossable.Tokenomics.award_tokens(user, 20)

      _ ->
        # if they're not on a 30-day streak, check for a 7-day streak
        case Crossable.Habits.get_habit_streak(user.id, 7) do
          7 ->
            {:ok, _} = Crossable.Tokenomics.award_tokens(user, 5)

          _ ->
            nil
        end
    end

    {:ok, _} = Crossable.Tokenomics.award_tokens(user, 2)
  end
end
