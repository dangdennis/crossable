defmodule Crossing.Raids.Raid do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raids" do
    field :deleted_at, :utc_datetime
    field :end_time, :utc_datetime
    field :player_limit, :integer
    field :status, :string
    field :raid_boss_id, :id

    timestamps()
  end

  @doc false
  def changeset(raid, attrs) do
    raid
    |> cast(attrs, [:player_limit, :status, :end_time, :deleted_at])
    |> validate_required([:player_limit, :status, :end_time, :deleted_at])
  end
end
