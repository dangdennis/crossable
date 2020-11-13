defmodule Crossable.Commands.Balance do
  def invoke(msg) do
    # find the discord user
    # find their wallet
    # DM their balance
    dm_channel = Nostrum.Api.create_dm!(msg.author.id)

    case Crossable.Tokenomics.get_wallet_by_discord_id(msg.author.id) do
      {:error, _} ->
        Nostrum.Api.create_message!(dm_channel.id, """
        You do not have a wallet.
        """)

      {:ok, wallet} ->
        Nostrum.Api.create_message!(dm_channel.id, """
        Your total token balance so far is #{wallet.balance}
        """)
    end

    Nostrum.Api.create_message!(dm_channel.id, """
    Your total token balance so far is
    """)
  end
end
