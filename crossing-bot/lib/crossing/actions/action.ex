defmodule Crossing.Actions.Action do
  use Ecto.Schema
  import Ecto.Changeset

  schema "actions" do
    field :value, :float
    field :unit, :string
    field :action_type_id, :id
    field :deleted_at, :utc_datetime
    field :avatar_id, :id

    timestamps()
  end

  @doc false
  def changeset(action, attrs) do
    action
    |> cast(attrs, [:value, :unit, :avatar_id, :action_type_id, :deleted_at])
    |> validate_required([:action_type_id, :value, :unit, :avatar_id, :action_type_id])
  end
end
