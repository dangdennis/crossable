defmodule Crossable.Schema.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :discord_user_id, :string
    field :username, :string
    field :password_hash, :string
    field :active, :boolean
    field :deleted_at, :utc_datetime
    has_one :avatar, Crossable.Schema.Avatars.Avatar
    has_one :wallet, Crossable.Schema.Tokenomics.Wallet

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :discord_user_id,
      :password_hash,
      :deleted_at,
      :active
    ])
    |> cast_assoc(:avatar, with: &Crossable.Schema.Avatars.Avatar.changeset/2)
    |> validate_required([:discord_user_id])
    |> unique_constraint([:discord_user_id])
  end
end
