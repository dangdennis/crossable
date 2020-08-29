defmodule Crossing.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :phone_number, :string
    field :password_hash, :string
    field :password, :string
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :phone_number, :password_hash, :deleted_at])
    |> validate_required([:username])
    |> unique_constraint([:username])
  end
end
