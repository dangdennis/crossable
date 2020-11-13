defmodule Crossable.Tokenomics.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :deleted_at, :utc_datetime
    field :balance, :float
    belongs_to :user, Crossable.Users.User
    has_many :transactions, Crossable.Tokenomics.Transaction

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:balance, :user_id, :deleted_at])
    |> validate_required([:balance, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end