defmodule Crossing.Actions.ActionType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "action_types" do
    field :name, :string
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(action_type, attrs) do
    action_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
