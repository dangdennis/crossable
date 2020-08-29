defmodule Crossing.Actions.Action do
  use Ecto.Schema
  import Ecto.Changeset

  schema "actions" do
    field :value, :float
    field :unit, :string
    field :action_type_id, :id
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(action, attrs) do
    action
    |> cast(attrs, [:name, :action_type_id, :value, :unit, :deleted_at])
    |> validate_required([:name, :action_type_id, :value, :unit])
  end
end
