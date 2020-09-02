defmodule Crossing.Wallets.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :balance, :float
    field :deleted_at, :utc_datetime
    # belongs_to :users, Crossing.Users.User

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:balance, :deleted_at])
    |> validate_required([:balance])
  end
end
