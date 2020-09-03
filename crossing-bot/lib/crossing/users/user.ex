defmodule Crossing.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :deleted_at, :utc_datetime
    field :email, :string
    field :password_hash, :string
    field :phone_number, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :phone_number, :password_hash, :deleted_at])
    |> validate_required([:username, :email, :phone_number, :password_hash])
  end
end
