defmodule Crossing.Collections.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do
    field :name, :string
    field :user_id, :id
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:name])
    |> validate_required([:name, :user_id])
  end
end
