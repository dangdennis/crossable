defmodule Crossing.Raids.RaidAttack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raid_attacks" do
    belongs_to :avatar, Crossing.Avatars.Avatar
    belongs_to :raid, Crossing.Raids.Raid
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(raid_attack, attrs) do
    raid_attack
    |> cast(attrs, [:deleted_at, :raid_id, :avatar_id])
    |> validate_required([:raid_id, :avatar_id])
  end
end
