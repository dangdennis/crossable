defmodule Crossing.ItemItemTypes do
  @moduledoc """
  The ItemItemTypes context.
  """

  import Ecto.Query, warn: false
  alias Crossing.Repo

  alias Crossing.ItemItemTypes.ItemItemType

  @doc """
  Returns the list of item_item_types.

  ## Examples

      iex> list_item_item_types()
      [%ItemItemType{}, ...]

  """
  def list_item_item_types do
    Repo.all(ItemItemType)
  end

  @doc """
  Gets a single item_item_type.

  Raises `Ecto.NoResultsError` if the Item item type does not exist.

  ## Examples

      iex> get_item_item_type!(123)
      %ItemItemType{}

      iex> get_item_item_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item_item_type!(id), do: Repo.get!(ItemItemType, id)

  @doc """
  Creates a item_item_type.

  ## Examples

      iex> create_item_item_type(%{field: value})
      {:ok, %ItemItemType{}}

      iex> create_item_item_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item_item_type(attrs \\ %{}) do
    %ItemItemType{}
    |> ItemItemType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item_item_type.

  ## Examples

      iex> update_item_item_type(item_item_type, %{field: new_value})
      {:ok, %ItemItemType{}}

      iex> update_item_item_type(item_item_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item_item_type(%ItemItemType{} = item_item_type, attrs) do
    item_item_type
    |> ItemItemType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item_item_type.

  ## Examples

      iex> delete_item_item_type(item_item_type)
      {:ok, %ItemItemType{}}

      iex> delete_item_item_type(item_item_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item_item_type(%ItemItemType{} = item_item_type) do
    Repo.delete(item_item_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item_item_type changes.

  ## Examples

      iex> change_item_item_type(item_item_type)
      %Ecto.Changeset{data: %ItemItemType{}}

  """
  def change_item_item_type(%ItemItemType{} = item_item_type, attrs \\ %{}) do
    ItemItemType.changeset(item_item_type, attrs)
  end
end
