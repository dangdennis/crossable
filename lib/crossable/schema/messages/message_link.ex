defmodule Crossable.Schema.Messages.MessageLink do
  @moduledoc """
  A MessageLink is a message in a chain of messages. Chains can link off one another at any given point,
  providing that the links are set properly to bridge chains.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "message_chains" do
    # the position of the message along the chain
    field :sequence_position, :integer

    field :chain_id, :integer

    # name is an additional field to help identify the chain
    field :name, :string

    field :content, :string

    # response_match indicates a leaf link that stores a message specific to a user response.
    field :response_match, :string

    timestamps()
  end

  @doc false
  def changeset(msg, attrs) do
    msg
    |> cast(attrs, [:sequence_position, :chain_id, :name, :content, :response_match])
    |> validate_required([:sequence_position, :chain_id, :content])
  end
end
