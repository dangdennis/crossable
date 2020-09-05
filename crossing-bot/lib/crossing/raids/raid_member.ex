defmodule Crossing.Raids.RaidMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raid_members" do
    field :active, :boolean, default: true
    field :deleted_at, :utc_datetime
    field :status, :string
    belongs_to :raid, Crossing.Raids.Raid
    belongs_to :avatar, Crossing.Avatars.Avatar

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
