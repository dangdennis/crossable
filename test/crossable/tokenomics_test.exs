defmodule Crossable.TokenomicsTest do
  use Crossable.DataCase

  alias Crossable.Tokenomics

  describe "wallets" do
    alias Crossable.Tokenomics.Wallet

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def wallet_fixture(attrs \\ %{}) do
      {:ok, wallet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tokenomics.create_wallet()

      wallet
    end

    test "list_wallets/0 returns all wallets" do
      wallet = wallet_fixture()
      assert Tokenomics.list_wallets() == [wallet]
    end

    test "get_wallet!/1 returns the wallet with given id" do
      wallet = wallet_fixture()
      assert Tokenomics.get_wallet!(wallet.id) == wallet
    end

    test "create_wallet/1 with valid data creates a wallet" do
      assert {:ok, %Wallet{} = wallet} = Tokenomics.create_wallet(@valid_attrs)
    end

    test "create_wallet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tokenomics.create_wallet(@invalid_attrs)
    end

    test "update_wallet/2 with valid data updates the wallet" do
      wallet = wallet_fixture()
      assert {:ok, %Wallet{} = wallet} = Tokenomics.update_wallet(wallet, @update_attrs)
    end

    test "update_wallet/2 with invalid data returns error changeset" do
      wallet = wallet_fixture()
      assert {:error, %Ecto.Changeset{}} = Tokenomics.update_wallet(wallet, @invalid_attrs)
      assert wallet == Tokenomics.get_wallet!(wallet.id)
    end

    test "delete_wallet/1 deletes the wallet" do
      wallet = wallet_fixture()
      assert {:ok, %Wallet{}} = Tokenomics.delete_wallet(wallet)
      assert_raise Ecto.NoResultsError, fn -> Tokenomics.get_wallet!(wallet.id) end
    end

    test "change_wallet/1 returns a wallet changeset" do
      wallet = wallet_fixture()
      assert %Ecto.Changeset{} = Tokenomics.change_wallet(wallet)
    end
  end

  describe "transactions" do
    alias Crossable.Tokenomics.Transaction

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tokenomics.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Tokenomics.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Tokenomics.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Tokenomics.create_transaction(@valid_attrs)
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tokenomics.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Tokenomics.update_transaction(transaction, @update_attrs)
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Tokenomics.update_transaction(transaction, @invalid_attrs)
      assert transaction == Tokenomics.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Tokenomics.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Tokenomics.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Tokenomics.change_transaction(transaction)
    end
  end
end
