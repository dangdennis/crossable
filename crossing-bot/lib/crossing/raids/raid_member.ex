defmodule Crossing.Raids.RaidMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raid_members" do
    field :active, :boolean, default: false
    field :deleted_at, :utc_datetime
    field :status, :string
    field :raid_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(raid_member, attrs) do
    raid_member
    |> cast(attrs, [:status, :active, :deleted_at])
    |> validate_required([:status, :active])
  end
end
