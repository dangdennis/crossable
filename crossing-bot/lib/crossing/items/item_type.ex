defmodule Crossing.Items.ItemType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_types" do
    field :name, :string
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(item_type, attrs) do
    item_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
