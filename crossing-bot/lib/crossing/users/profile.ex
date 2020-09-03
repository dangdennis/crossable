defmodule Crossing.Users.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :age, :integer
    field :deleted_at, :utc_datetime
    field :first_name, :string
    field :last_name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :age, :deleted_at])
    |> validate_required([:first_name, :last_name, :age, :deleted_at])
  end
end
