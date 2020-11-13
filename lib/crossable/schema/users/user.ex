defmodule Crossable.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :deleted_at, :utc_datetime
    field :discord_user_id, :string
    field :password_hash, :string
    field :active, :boolean
    has_one :avatar, Crossable.Avatars.Avatar
    has_one :wallet, Crossable.Tokenomics.Wallet

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :discord_user_id,
      :password_hash,
      :deleted_at,
      :active
    ])
    |> validate_required([:discord_user_id])
    |> unique_constraint([:discord_user_id])
  end
end