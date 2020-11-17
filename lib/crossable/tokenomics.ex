defmodule Crossable.Tokenomics do
  @moduledoc """
  The Tokenomics context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo

  #####################
  # WALLET
  #####################

  alias Crossable.Schema.Tokenomics.Wallet

  @doc """
  Returns the wallet belonging to a discord user.any()

  ## Examples

      iex> get_wallet_by_discord_id(412)
      {:ok, wallet}

  """
  def get_wallet_by_discord_id(discord_id) do
    query =
      from w in Wallet,
        join: u in Crossable.Schema.Users.User,
        on: w.user_id == u.id,
        where: u.discord_user_id == ^discord_id

    case Repo.one(query) do
      nil -> {:error, "failed to find wallet"}
      wallet -> {:ok, wallet}
    end
  end

  @doc """
  Returns the wallet belonging to a user

  ## Examples

      iex> get_user_wallet(412)
      {:ok, wallet}

  """
  def get_user_wallet(user_id) do
    query =
      from w in Wallet,
        where: w.user_id == ^user_id

    case Repo.one(query) do
      nil -> {:error, "failed to find wallet"}
      wallet -> {:ok, wallet}
    end
  end

  @doc """
  Returns the list of wallets.

  ## Examples

      iex> list_wallets()
      [%Wallet{}, ...]

  """
  def list_wallets do
    Repo.all(Wallet)
  end

  @doc """
  Gets a single wallet.

  Raises `Ecto.NoResultsError` if the Wallet does not exist.

  ## Examples

      iex> get_wallet!(123)
      %Wallet{}

      iex> get_wallet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wallet!(id), do: Repo.get!(Wallet, id)

  @doc """
  Creates a wallet.

  ## Examples

      iex> create_wallet(%{field: value})
      {:ok, %Wallet{}}

      iex> create_wallet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wallet(attrs \\ %{}) do
    %Wallet{}
    |> Wallet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a wallet by association for a user.

  ## Examples

    iex> create_wallet_for_user(%Crossable.Schema.Users.User{field:value})
    {:ok, %Avatar{}}

    iex> create_wallet_for_user(%{field: bad_value})
    {:error, %Ecto.Changeset{}}
  """
  def create_wallet_for_user(user) do
    Ecto.build_assoc(user, :wallet, %{})
    |> Repo.insert()
  end

  @doc """
  Updates a wallet.

  ## Examples

      iex> update_wallet(wallet, %{field: new_value})
      {:ok, %Wallet{}}

      iex> update_wallet(wallet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wallet(%Wallet{} = wallet, attrs) do
    wallet
    |> Wallet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a wallet.

  ## Examples

      iex> delete_wallet(wallet)
      {:ok, %Wallet{}}

      iex> delete_wallet(wallet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wallet(%Wallet{} = wallet) do
    Repo.delete(wallet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wallet changes.

  ## Examples

      iex> change_wallet(wallet)
      %Ecto.Changeset{data: %Wallet{}}

  """
  def change_wallet(%Wallet{} = wallet, attrs \\ %{}) do
    Wallet.changeset(wallet, attrs)
  end

  #####################
  # TRANSACTIONS
  #####################

  alias Crossable.Schema.Tokenomics.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  @doc """
  Awards tokens to a user

  ## Examples

      iex> award_tokens(user, 5)
      {:ok, wallet}
  """
  def award_tokens(user, amount) do
    {:ok, wallet} = Crossable.Tokenomics.get_user_wallet(user.id)

    {:ok, _} =
      Crossable.Tokenomics.create_transaction(%{
        amount: amount,
        wallet_id: wallet.id
      })

    {:ok, _} = Crossable.Tokenomics.update_wallet(wallet, %{balance: wallet.balance + amount})

    {:ok, wallet}
  end
end
