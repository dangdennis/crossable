defmodule Crossing.Users.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :deleted_at, :utc_datetime
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :username, :string
    belongs_to :user, Crossing.Users.User

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :username, :email, :phone_number, :deleted_at])
    |> validate_required([:first_name, :last_name, :username, :email, :phone_number])
  end
end
