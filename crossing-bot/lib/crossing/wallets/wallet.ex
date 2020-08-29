defmodule Crossing.Wallets.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :balance, :float
    field :user_id, :id
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:balance, :user_id, :deleted_at])
    |> validate_required([:balance, :user_id])
  end
end
