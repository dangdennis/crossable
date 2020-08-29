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

Faker.start()

# USERS

defmodule Factory do
  def user_factory() do
    %Crossing.Users.User{
      username:
        (Faker.Person.name() |> String.split(" ", trim: true) |> Enum.join()) <>
          "#" <>
          Integer.to_string(Enum.random(1_000..9_999)),
      email:
        (Faker.Person.name() |> String.split(" ", trim: true) |> Enum.join()) <>
          "email" <> Integer.to_string(Enum.random(1_000..9_999)) <> "@gmail.com",
      phone_number: Faker.Phone.EnUs.phone()
    }
  end
end

user1 = Crossing.Repo.insert!(user_factory())

user2 = Crossing.Repo.insert!(user_factory())

# WALLETS

Crossing.Repo.insert!(%Crossing.Wallets.Wallet{
  balance: 1000.0,
  user_id: user1.id
})

Crossing.Repo.insert!(%Crossing.Wallets.Wallet{
  balance: 1000.0,
  user_id: user2.id
})
