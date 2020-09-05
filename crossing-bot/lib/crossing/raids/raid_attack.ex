defmodule Crossing.Raids.Attack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raid_members" do
    belongs_to :avatar, Crossing.Avatars.Avatar
    belongs_to :raid, Crossing.Raids.Raid
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(raid_member, attrs) do
    raid_member
    |> cast(attrs, [:status, :active, :deleted_at, :raid_id, :avatar_id])
    |> unique_constraint([:avatar_id, :raid_id], name: "raid_members_avatar_id_raid_id_index")
    |> validate_required([:status, :active])
  end
end
