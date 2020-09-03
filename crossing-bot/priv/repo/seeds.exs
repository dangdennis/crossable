# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Crossing.Repo.insert!(%Crossing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Faker.start()

# defmodule Factory do
#   def build(:user) do
#     %Crossing.Users.User{
#       username:
#         (Faker.Person.name() |> String.split(" ", trim: true) |> Enum.join()) <>
#           "#" <>
#           Integer.to_string(Enum.random(1_000..9_999)),
#       email:
#         (Faker.Person.name() |> String.split(" ", trim: true) |> Enum.join()) <>
#           "email" <> Integer.to_string(Enum.random(1_000..9_999)) <> "@gmail.com",
#       phone_number: Faker.Phone.EnUs.phone()
#     }
#   end

#   def build(:profile) do
#     %Crossing.Users.Profile{
#       first_name: Faker.Person.first_name(),
#       last_name: Faker.Person.last_name()
#     }
#   end

#   def build(:avatar) do
#     %Crossing.Avatars.Avatar{}
#   end
# end

# USERS
# user1 = Crossing.Repo.insert!(Factory.build(:user))
# user2 = Crossing.Repo.insert!(Factory.build(:user))

# PROFILES
# Crossing.Repo.insert!(Factory.profile_factory(user1.id))
# Crossing.Repo.insert!(Factory.profile_factory(user2.id))

# AVATARS
# avatar1 = Crossing.Repo.insert!(Factory.build(:avatar))
# avatar2 = Crossing.Repo.insert!(Factory.build(:avatar))
