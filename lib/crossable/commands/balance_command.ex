defmodule Crossable.Commands.Balance do
  def invoke(msg) do
    # find the discord user
    # find their wallet
    # DM their balance
    dm_channel = Nostrum.Api.create_dm!(msg.author.id)

    Crossable.Tokenomics.get_wallet_by_discord_id(msg.author.id |> Integer.to_string())
    |> handle_balance_retrieval(dm_channel.id)
  end

  def handle_balance_retrieval({:ok, wallet}, channel_id) do
    Nostrum.Api.create_message!(channel_id, """
    Your total balance is #{wallet.balance |> :erlang.float_to_binary(decimals: 0)}.
    """)
  end

  def handle_balance_retrieval({:error, _reason}, channel_id) do
    Nostrum.Api.create_message!(channel_id, """
    You do not have a wallet.
    """)
  end
end
