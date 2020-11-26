defmodule Crossable.Dialogs do
  @moduledoc """
  The Dialogs context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo

  @spec create_dialog_flow(Map.t()) :: nil
  def create_dialog_flow(attrs \\ %{}) do
    %Crossable.Schema.Dialogs.DialogFlow{}
    |> Crossable.Schema.Dialogs.DialogFlow.changeset(attrs)
    |> Repo.insert()
  end
end
