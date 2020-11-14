defmodule Crossable.Schema.Tokenomics.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :deleted_at, :utc_datetime
    field :balance, :float
    belongs_to :user, Crossable.Schema.Users.User
    has_many :transactions, Crossable.Schema.Tokenomics.Transaction

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:balance, :user_id, :deleted_at])
    |> validate_required([:user_id])
    |> foreign_key_constraint(:user_id)
  end
end
