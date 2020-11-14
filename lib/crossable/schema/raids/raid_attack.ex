defmodule Crossable.Schema.Raids.RaidAttack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raid_attacks" do
    belongs_to :raid_member, Crossable.Schema.Raids.RaidMember
    belongs_to :raid, Crossable.Schema.Raids.Raid
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(raid_attack, attrs) do
    raid_attack
    |> cast(attrs, [:deleted_at, :raid_id, :raid_member_id])
    |> validate_required([:raid_id, :raid_member_id])
  end
end
