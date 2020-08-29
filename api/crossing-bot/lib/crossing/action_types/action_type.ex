defmodule Crossing.ActionTypes.ActionType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "action_types" do
    field :deleted_at, :utc_datetime
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(action_type, attrs) do
    action_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name, :deleted_at])
  end
end
