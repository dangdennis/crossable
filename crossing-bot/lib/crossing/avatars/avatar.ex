defmodule Crossing.Avatars.Avatar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "avatars" do
    field :user_id, :id
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(avatar, attrs) do
    avatar
    |> cast(attrs, [:user_id, :deleted_at])
    |> validate_required([:user_id])
  end
end
