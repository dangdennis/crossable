defmodule Crossing.Factory do
  alias Crossing.Repo

  # Factories

  def build(:avatar) do
    %Crossing.Avatars.Avatar{}
  end

  def build(:raid) do
    %Crossing.Raids.Raid{}
  end

  def build(:raid_boss) do
    %Crossing.Raids.RaidBoss{}
  end

  def build(:raid_member) do
    %Crossing.Raids.RaidMember{}
  end

  def build(:user) do
    %Crossing.Users.User{}
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
