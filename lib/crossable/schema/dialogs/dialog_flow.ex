defmodule Crossable.Schema.Dialogs.DialogFlow do
  @moduledoc """
  A DialogFlow is a series of dialog links that are periodically sent to channels.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "dialog_flows" do
    field :name, :string
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(dialog_flow, attrs) do
    dialog_flow
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
    |> unique_constraint([:name])
  end
end
