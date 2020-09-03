defmodule Crossing.Raids.RaidBoss do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raid_bosses" do
    field :deleted_at, :utc_datetime
    field :image_url, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(raid_boss, attrs) do
    raid_boss
    |> cast(attrs, [:name, :image_url, :deleted_at])
    |> validate_required([:name, :image_url, :deleted_at])
  end
end
