defmodule Crossable.TokenomicsTest do
  use Crossable.DataCase

  alias Crossable.Tokenomics

  describe "wallets" do
    alias Crossable.Users
    alias Crossable.Schema.Tokenomics.Wallet

    @valid_attrs %{
      user_id: 1,
      wallet_id: 1,
      balance: 0
    }
    @update_attrs %{
      user_id: 2
    }
    @invalid_attrs %{
      user_id: nil,
      balance: nil
    }

    def wallet_fixture(attrs \\ %{}) do
      {:ok, wallet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tokenomics.create_wallet()

      wallet
    end

    test "get_wallet_by_discord_id/1" do
      discord_id = "afsfasfsaf"
      {:ok, user} = Users.create_user(%{discord_user_id: discord_id})
      wallet = wallet_fixture(%{user_id: user.id})
      assert {:ok, wallet} == Tokenomics.get_wallet_by_discord_id(discord_id)
    end

    test "list_wallets/0 returns all wallets" do
      {:ok, user} = Users.create_user(%{discord_user_id: "afsfasfsaf"})
      wallet = wallet_fixture(%{user_id: user.id})
      assert Tokenomics.list_wallets() == [wallet]
    end

    test "get_wallet!/1 returns the wallet with given id" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id, balance: 0})
      assert Tokenomics.get_wallet!(wallet.id) == wallet
    end

    test "create_wallet/1 with valid data creates a wallet" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      assert {:ok, %Wallet{}} = Tokenomics.create_wallet(%{user_id: user.id})
    end

    test "create_wallet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tokenomics.create_wallet(@invalid_attrs)
    end

    test "update_wallet/2 with valid data updates the wallet" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, user2} = Users.create_user(%{discord_user_id: "asdfasxxx"})
      wallet = wallet_fixture(%{user_id: user.id})
      assert {:ok, %Wallet{}} = Tokenomics.update_wallet(wallet, %{user_id: user2.id})
    end

    test "update_wallet/2 with invalid data returns error changeset" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id, balance: 0})
      assert {:error, %Ecto.Changeset{}} = Tokenomics.update_wallet(wallet, @invalid_attrs)
      assert wallet == Tokenomics.get_wallet!(wallet.id)
    end

    test "delete_wallet/1 deletes the wallet" do
      {:ok, user} = Users.create_user(%{discord_user_id: "fadfasfsf341312"})
      wallet = wallet_fixture(%{user_id: user.id})
      assert {:ok, %Wallet{}} = Tokenomics.delete_wallet(wallet)
      assert_raise Ecto.NoResultsError, fn -> Tokenomics.get_wallet!(wallet.id) end
    end

    test "change_wallet/1 returns a wallet changeset" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfa3412342s"})
      wallet = wallet_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Tokenomics.change_wallet(wallet)
    end
  end

  describe "transactions" do
    alias Crossable.Schema.Tokenomics.Transaction
    alias Crossable.Users

    @valid_attrs %{
      amount: 500
    }
    @update_attrs %{
      amount: 500
    }
    @invalid_attrs %{
      amount: "500"
    }

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tokenomics.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id})
      transaction = transaction_fixture(%{wallet_id: wallet.id})
      assert Tokenomics.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id})
      transaction = transaction_fixture(%{wallet_id: wallet.id})
      assert Tokenomics.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id})

      assert {:ok, %Transaction{}} =
               Tokenomics.create_transaction(%{wallet_id: wallet.id, amount: 200})
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tokenomics.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id})
      transaction = transaction_fixture(%{wallet_id: wallet.id})

      assert {:ok, %Transaction{}} = Tokenomics.update_transaction(transaction, @update_attrs)
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id})
      transaction = transaction_fixture(%{wallet_id: wallet.id})

      assert {:error, %Ecto.Changeset{}} =
               Tokenomics.update_transaction(transaction, %{wallet_id: nil})

      assert transaction == Tokenomics.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id})
      transaction = transaction_fixture(%{wallet_id: wallet.id})

      assert {:ok, %Transaction{}} = Tokenomics.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Tokenomics.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      {:ok, user} = Users.create_user(%{discord_user_id: "asdfas"})
      {:ok, wallet} = Tokenomics.create_wallet(%{user_id: user.id})
      transaction = transaction_fixture(%{wallet_id: wallet.id})
      assert %Ecto.Changeset{} = Tokenomics.change_transaction(transaction)
    end
  end
end
