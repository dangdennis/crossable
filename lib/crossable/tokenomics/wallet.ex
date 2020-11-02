defmodule Crossable.Tokenomics.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :deleted_at, :utc_datetime
    belongs_to :user, Crossable.Users.User

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:user_id, :deleted_at])
    |> validate_required([])
  end
end
