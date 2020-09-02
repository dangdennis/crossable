defmodule Crossing.Users.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
    field :user_id, :id
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :age, :user_id, :deleted_at])
    |> validate_required([:first_name, :last_name, :age, :user_id])
  end
end
