defmodule Crossable.Schema.Messages.MessageLinkCursor do
  @moduledoc """
  A cursor to indicate where a user is in a message chain.
  A user should only have one cursor.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "message_chain_cursors" do
    belongs_to :user, Crossable.Schema.Users.User
    belongs_to :message_link, Crossable.Schema.Messages.MessageLink

    timestamps()
  end

  @doc false
  def changeset(cursor, attrs) do
    cursor
    |> cast(attrs, [:user_id, :message_link_id])
    |> validate_required([:user_id, :message_link_id])
  end
end
