defmodule Crossable.Commands.MyHabit do
  @spec invoke(Nostrum.Struct.Message.t()) :: Nostrum.Struct.Message.t()
  def invoke(msg) do
    # retrieve the user's current habit
    {:ok, user_habit} =
      Crossable.Habits.get_active_user_habit_by_discord_id(
        msg.author.id
        |> Integer.to_string()
      )

    dm_channel = Nostrum.Api.create_dm!(msg.author.id)

    Nostrum.Api.create_message!(dm_channel.id, """
    Your habit is #{user_habit.habit}
    """)

    # Crossable.Tokenomics.get_wallet_by_discord_id(msg.author.id |> Integer.to_string())
    # |> handle_balance_retrieval(dm_channel.id)
  end
end
