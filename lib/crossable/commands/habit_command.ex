defmodule Crossable.Commands.MyHabit do
  def invoke(msg) do
    dm_channel = Nostrum.Api.create_dm!(msg.author.id)

    Nostrum.Api.create_message!(dm_channel.id, """
    Your habit is
    """)

    # Crossable.Tokenomics.get_wallet_by_discord_id(msg.author.id |> Integer.to_string())
    # |> handle_balance_retrieval(dm_channel.id)
  end

  def handle_user_habit({:ok, wallet}, channel_id) do
    Nostrum.Api.create_message!(channel_id, """
    Your total balance is #{wallet.balance |> :erlang.float_to_binary(decimals: 0)}.
    """)
  end

  def handle_user_habit({:error, _reason}, channel_id) do
    Nostrum.Api.create_message!(channel_id, """
    You do not have a wallet.
    """)
  end
end
