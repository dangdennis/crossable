defmodule Crossing.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :type_id, :id
    field :image_url, :string
    field :collection_id, :id
    field :avatar_id, :id
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :type_id, :image_url, :avatar_id, :collection_id, :deleted_at])
    |> validate_required([:name, :type_id, :image_url, :avatar_id, :collection_id])
  end
end
