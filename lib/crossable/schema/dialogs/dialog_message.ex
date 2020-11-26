defmodule Crossable.Schema.Dialogs.DialogMessage do
  @moduledoc """
  A DialogMessage is a message in a chain of messages.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "dialog_messages" do
    # the position of the message along the chain
    belongs_to :dialog_flow, Crossable.Schema.Dialogs.DialogFlow
    field :sequence_position, :float
    field :content, :string

    # response_match indicates a leaf link that stores a message specific to a user response.
    field :response_match, :string

    timestamps()
    field :deleted_at, :utc_datetime
  end

  @doc false
  def changeset(msg, attrs) do
    msg
    |> cast(attrs, [:sequence_position, :dialog_flow_id, :content, :response_match])
    |> validate_required([:sequence_position, :dialog_flow_id, :content])
  end
end
