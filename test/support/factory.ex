defmodule Crossable.Factory do
  alias Crossable.Repo

  # Factories

  def build(:avatar) do
    %Crossable.Avatars.Avatar{}
  end

  def build(:raid) do
    %Crossable.Raids.Raid{}
  end

  def build(:raid_boss) do
    %Crossable.Raids.RaidBoss{}
  end

  def build(:raid_member) do
    %Crossable.Raids.RaidMember{}
  end

  def build(:user) do
    %Crossable.Users.User{}
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
