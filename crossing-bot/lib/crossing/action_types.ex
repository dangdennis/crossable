defmodule Crossing.ActionTypes do
  @moduledoc """
  The ActionTypes context.
  """

  import Ecto.Query, warn: false
  alias Crossing.Repo

  alias Crossing.Actions.ActionType

  @doc """
  Returns the list of action_types.

  ## Examples

      iex> list_action_types()
      [%ActionType{}, ...]

  """
  def list_action_types do
    Repo.all(ActionType)
  end

  @doc """
  Gets a single action_type.

  Raises `Ecto.NoResultsError` if the Action type does not exist.

  ## Examples

      iex> get_action_type!(123)
      %ActionType{}

      iex> get_action_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_action_type!(id), do: Repo.get!(ActionType, id)

  @doc """
  Creates a action_type.

  ## Examples

      iex> create_action_type(%{field: value})
      {:ok, %ActionType{}}

      iex> create_action_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_action_type(attrs \\ %{}) do
    %ActionType{}
    |> ActionType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a action_type.

  ## Examples

      iex> update_action_type(action_type, %{field: new_value})
      {:ok, %ActionType{}}

      iex> update_action_type(action_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_action_type(%ActionType{} = action_type, attrs) do
    action_type
    |> ActionType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a action_type.

  ## Examples

      iex> delete_action_type(action_type)
      {:ok, %ActionType{}}

      iex> delete_action_type(action_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_action_type(%ActionType{} = action_type) do
    Repo.delete(action_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking action_type changes.

  ## Examples

      iex> change_action_type(action_type)
      %Ecto.Changeset{data: %ActionType{}}

  """
  def change_action_type(%ActionType{} = action_type, attrs \\ %{}) do
    ActionType.changeset(action_type, attrs)
  end
end
