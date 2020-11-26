defmodule Crossable.Dialogs do
  @moduledoc """
  The Dialogs context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo

  @doc """
  Creates a new dialog flow.
  """
  def create_dialog_flow(attrs \\ %{}) do
    %Crossable.Schema.Dialogs.DialogFlow{}
    |> Crossable.Schema.Dialogs.DialogFlow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a new dialog message. A dialog message exists as one of many in a dialog flow.
  """
  def create_dialog_message(attrs \\ %{}) do
    %Crossable.Schema.Dialogs.DialogMessage{}
    |> Crossable.Schema.Dialogs.DialogMessage.changeset(attrs)
    |> Repo.insert()
  end
end
