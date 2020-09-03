defmodule Crossing.Raids do
  @moduledoc """
  The Raids context.
  """

  import Ecto.Query, warn: false
  alias Crossing.Repo

  alias Crossing.Raids.RaidBoss

  @doc """
  Returns the list of raid_bosses.

  ## Examples

      iex> list_raid_bosses()
      [%RaidBoss{}, ...]

  """
  def list_raid_bosses do
    Repo.all(RaidBoss)
  end

  @doc """
  Gets a single raid_boss.

  Raises `Ecto.NoResultsError` if the Raid boss does not exist.

  ## Examples

      iex> get_raid_boss!(123)
      %RaidBoss{}

      iex> get_raid_boss!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raid_boss!(id), do: Repo.get!(RaidBoss, id)

  @doc """
  Creates a raid_boss.

  ## Examples

      iex> create_raid_boss(%{field: value})
      {:ok, %RaidBoss{}}

      iex> create_raid_boss(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raid_boss(attrs \\ %{}) do
    %RaidBoss{}
    |> RaidBoss.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raid_boss.

  ## Examples

      iex> update_raid_boss(raid_boss, %{field: new_value})
      {:ok, %RaidBoss{}}

      iex> update_raid_boss(raid_boss, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raid_boss(%RaidBoss{} = raid_boss, attrs) do
    raid_boss
    |> RaidBoss.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raid_boss.

  ## Examples

      iex> delete_raid_boss(raid_boss)
      {:ok, %RaidBoss{}}

      iex> delete_raid_boss(raid_boss)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raid_boss(%RaidBoss{} = raid_boss) do
    Repo.delete(raid_boss)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raid_boss changes.

  ## Examples

      iex> change_raid_boss(raid_boss)
      %Ecto.Changeset{data: %RaidBoss{}}

  """
  def change_raid_boss(%RaidBoss{} = raid_boss, attrs \\ %{}) do
    RaidBoss.changeset(raid_boss, attrs)
  end

  alias Crossing.Raids.Raid

  @doc """
  Returns the list of raids.

  ## Examples

      iex> list_raids()
      [%Raid{}, ...]

  """
  def list_raids do
    Repo.all(Raid)
  end

  @doc """
  Gets a single raid.

  Raises `Ecto.NoResultsError` if the Raid does not exist.

  ## Examples

      iex> get_raid!(123)
      %Raid{}

      iex> get_raid!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raid!(id), do: Repo.get!(Raid, id)

  @doc """
  Creates a raid.

  ## Examples

      iex> create_raid(%{field: value})
      {:ok, %Raid{}}

      iex> create_raid(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raid(attrs \\ %{}) do
    %Raid{}
    |> Raid.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raid.

  ## Examples

      iex> update_raid(raid, %{field: new_value})
      {:ok, %Raid{}}

      iex> update_raid(raid, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raid(%Raid{} = raid, attrs) do
    raid
    |> Raid.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raid.

  ## Examples

      iex> delete_raid(raid)
      {:ok, %Raid{}}

      iex> delete_raid(raid)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raid(%Raid{} = raid) do
    Repo.delete(raid)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raid changes.

  ## Examples

      iex> change_raid(raid)
      %Ecto.Changeset{data: %Raid{}}

  """
  def change_raid(%Raid{} = raid, attrs \\ %{}) do
    Raid.changeset(raid, attrs)
  end
end
