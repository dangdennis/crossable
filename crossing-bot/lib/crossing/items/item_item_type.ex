defmodule Crossing.Items.ItemItemType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_item_types" do
    field :item_id, :id
    field :item_types_id, :id
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(item_item_type, attrs) do
    item_item_type
    |> cast(attrs, [:item_id, :item_types_id, :deleted_at])
    |> validate_required([:item_id, :item_types_id])
  end
end
