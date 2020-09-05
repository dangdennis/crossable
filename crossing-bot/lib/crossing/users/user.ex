defmodule Crossing.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :deleted_at, :utc_datetime
    field :discord_user_id, :string
    field :password_hash, :string
    has_one :avatar, Crossing.Avatars.Avatar

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :discord_user_id,
      :password_hash,
      :deleted_at,
      :avatar_id
    ])
    |> validate_required([:discord_user_id])
    |> unique_constraint([:discord_user_id])
  end
end
