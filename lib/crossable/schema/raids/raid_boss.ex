defmodule Crossable.Schema.Raids.RaidBoss do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raid_bosses" do
    field(:name, :string)
    field(:image_url, :string)
    timestamps()
    field(:deleted_at, :utc_datetime)
  end

  @doc false
  def changeset(raid_boss, attrs) do
    raid_boss
    |> cast(attrs, [:name, :image_url, :deleted_at])
    |> validate_required([:name, :image_url])
    |> unique_constraint([:name], name: :raid_bosses_name_index)
  end
end
