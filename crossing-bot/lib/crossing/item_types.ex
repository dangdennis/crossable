defmodule Crossing.ItemTypes do
  @moduledoc """
  The ItemTypes context.
  """

  import Ecto.Query, warn: false
  alias Crossing.Repo

  alias Crossing.Items.ItemType

  @doc """
  Returns the list of item_types.

  ## Examples

      iex> list_item_types()
      [%ItemType{}, ...]

  """
  def list_item_types do
    Repo.all(ItemType)
  end

  @doc """
  Gets a single item_type.

  Raises `Ecto.NoResultsError` if the Item type does not exist.

  ## Examples

      iex> get_item_type!(123)
      %ItemType{}

      iex> get_item_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item_type!(id), do: Repo.get!(ItemType, id)

  @doc """
  Creates a item_type.

  ## Examples

      iex> create_item_type(%{field: value})
      {:ok, %ItemType{}}

      iex> create_item_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item_type(attrs \\ %{}) do
    %ItemType{}
    |> ItemType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item_type.

  ## Examples

      iex> update_item_type(item_type, %{field: new_value})
      {:ok, %ItemType{}}

      iex> update_item_type(item_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item_type(%ItemType{} = item_type, attrs) do
    item_type
    |> ItemType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item_type.

  ## Examples

      iex> delete_item_type(item_type)
      {:ok, %ItemType{}}

      iex> delete_item_type(item_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item_type(%ItemType{} = item_type) do
    Repo.delete(item_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item_type changes.

  ## Examples

      iex> change_item_type(item_type)
      %Ecto.Changeset{data: %ItemType{}}

  """
  def change_item_type(%ItemType{} = item_type, attrs \\ %{}) do
    ItemType.changeset(item_type, attrs)
  end
end
