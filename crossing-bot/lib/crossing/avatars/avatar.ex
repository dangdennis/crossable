defmodule Crossing.Avatars.Avatar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "avatars" do
    field :deleted_at, :utc_datetime
    belongs_to :user, Crossing.Users.User

    timestamps()
  end

  @doc false
  def changeset(avatar, attrs) do
    avatar
    |> cast(attrs, [:user_id, :deleted_at])
    |> validate_required([])
  end
end
