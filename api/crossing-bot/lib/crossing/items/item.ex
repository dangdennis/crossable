defmodule Crossing.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :type, :string
    field :image_url, :string
    field :collection_id, :id
    field :deleted_at, :utc_datetime


    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :type, :image_url, :deleted_at])
    |> validate_required([:name, :type, :image_url, :deleted_at])
  end
end
