defmodule Crossing.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :username, :string
    has_one :wallet, Wallets.Wallet

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username])
    |> validate_required([:firstname, :lastname, :username])
  end
end
