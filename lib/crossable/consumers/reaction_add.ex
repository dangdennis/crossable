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
        user_response = "yes"
        Logger.info("got a thumbs up yessss response!")

        {:ok, _entry} =
          Crossable.Habits.create_habit_log_entry(%{
            user_id: user.id,
            habit_id: habit_reminder.habit_id,
            status: "completed"
          })

        spawn(fn ->
          Crossable.Habits.update_habit_reminder(habit_reminder, %{response: user_response})
        end)

        {:ok, dialog_message} =
          Crossable.Dialogs.get_next_dialog_message_to_channel(
            reaction.channel_id
            |> Integer.to_string(),
            user_response
          )

        spawn(fn -> Nostrum.Api.create_message!(reaction.channel_id, dialog_message.content) end)

        spawn(fn -> award_tokens_with_streaks(user, reaction.channel_id) end)

        spawn(fn ->
          Crossable.Messages.broadcast_message("""
          #{user.username} did their habit today!
          """)
        end)

      {"❌", nil} ->
        user_response = "no"
        Logger.info("got a thumbs down nooooo response!")

        {:ok, _entry} =
          Crossable.Habits.create_habit_log_entry(%{
            user_id: user.id,
            habit_id: habit_reminder.habit_id,
            status: "incomplete"
          })

        spawn(fn ->
          Crossable.Habits.update_habit_reminder(habit_reminder, %{response: user_response})
        end)

        {:ok, dialog_message} =
          Crossable.Dialogs.get_next_dialog_message_to_channel(
            reaction.channel_id
            |> Integer.to_string(),
            user_response
          )

        spawn(fn -> Nostrum.Api.create_message!(reaction.channel_id, dialog_message.content) end)

        spawn(fn -> {:ok, _} = Crossable.Tokenomics.award_tokens(user, 1) end)

        Nostrum.Api.create_message!(reaction.channel_id, "Here's one token!")

      {_, _} ->
        Logger.info(%{
          message: "habit reminder already handled once",
          habit_reminder: habit_reminder.id
        })
    end
  end

  def handle_habit_reminder_response({:error, reason}, _reaction, user) do
    Logger.error(reason <> " for user id" <> (user.id |> Integer.to_string()))
  end

  def award_tokens_with_streaks(user, channel_id) do
    # query the user's habit logs for streaks
    # first check for a 30-day streak
    case Crossable.Habits.get_habit_streak(user.id, 30) do
      30 ->
        {:ok, _} = Crossable.Tokenomics.award_tokens(user, 20)
        Nostrum.Api.create_message!(channel_id, "You earned 20 tokens for a crazy 30-day streak!")

      _ ->
        # if they're not on a 30-day streak, check for a 7-day streak
        case Crossable.Habits.get_habit_streak(user.id, 7) do
          7 ->
            {:ok, _} = Crossable.Tokenomics.award_tokens(user, 5)

            Nostrum.Api.create_message!(
              channel_id,
              "You earned 5 tokens for a great 7-day streak!"
            )

          _ ->
            nil
        end
    end

    {:ok, _} = Crossable.Tokenomics.award_tokens(user, 2)
    Nostrum.Api.create_message!(channel_id, "Here are 2 tokens!")
  end
end
