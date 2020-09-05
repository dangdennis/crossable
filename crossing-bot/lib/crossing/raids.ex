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

  @spec get_active_raid :: Raid
  def get_active_raid do
    from(Raid,
      where: [active: true],
      select: [:id, :active, :start_time, :end_time, :completion_percentage, :raid_bosses_id],
      order_by: [asc: :start_time],
      limit: 1,
      preload: [:raid_bosses]
    )
    |> Repo.one()
  end

  @spec get_raid!(any) :: any
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

  alias Crossing.Raids.RaidMember

  @doc """
  Returns the list of raid_members.

  ## Examples

      iex> list_raid_members()
      [%RaidMember{}, ...]

  """
  def list_raid_members do
    Repo.all(RaidMember)
  end

  @doc """
  Gets a single raid_member.

  Raises `Ecto.NoResultsError` if the Raid member does not exist.

  ## Examples

      iex> get_raid_member!(123)
      %RaidMember{}

      iex> get_raid_member!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raid_member!(id), do: Repo.get!(RaidMember, id)

  @doc """
  Creates a raid_member.

  ## Examples

      iex> create_raid_member(%{field: value})
      {:ok, %RaidMember{}}

      iex> create_raid_member(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raid_member(attrs \\ %{}) do
    %RaidMember{}
    |> RaidMember.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raid_member.

  ## Examples

      iex> update_raid_member(raid_member, %{field: new_value})
      {:ok, %RaidMember{}}

      iex> update_raid_member(raid_member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raid_member(%RaidMember{} = raid_member, attrs) do
    raid_member
    |> RaidMember.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raid_member.

  ## Examples

      iex> delete_raid_member(raid_member)
      {:ok, %RaidMember{}}

      iex> delete_raid_member(raid_member)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raid_member(%RaidMember{} = raid_member) do
    Repo.delete(raid_member)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raid_member changes.

  ## Examples

      iex> change_raid_member(raid_member)
      %Ecto.Changeset{data: %RaidMember{}}

  """
  def change_raid_member(%RaidMember{} = raid_member, attrs \\ %{}) do
    RaidMember.changeset(raid_member, attrs)
  end
end
