defmodule Crossable.Factory do
  alias Crossable.Repo

  # Factories

  def build(:avatar) do
    %Crossable.Schema.Avatars.Avatar{}
  end

  def build(:raid) do
    %Crossable.Schema.Raids.Raid{}
  end

  def build(:raid_boss) do
    %Crossable.Schema.Raids.RaidBoss{}
  end

  def build(:raid_member) do
    %Crossable.Schema.Raids.RaidMember{}
  end

  def build(:user) do
    %Crossable.Schema.Users.User{}
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
