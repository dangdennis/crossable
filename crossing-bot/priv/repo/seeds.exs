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

  def wallet_factory(user_id, balance) do
    %Crossing.Wallets.Wallet{
      user_id: user_id,
      balance: balance
    }
  end

  def profile_factory(user_id) do
    %Crossing.Profiles.Profile{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      user_id: user_id
    }
  end

  def item_type_factory(type) do
    %Crossing.ItemTypes.ItemType{
      name: type
    }
  end

  def item_item_type_factory(item_id, item_types_id) do
    %Crossing.ItemItemTypes.ItemItemType{
      item_id: item_id,
      item_types_id: item_types_id
    }
  end

  def item_factory(name) do
    %Crossing.Items.Item{
      name: name
    }
  end

  def collection_factory(name, user_id) do
    %Crossing.Collections.Collection{
      name: name,
      user_id: user_id
    }
  end

  def avatar_factory(user_id) do
    %Crossing.Avatars.Avatar{
      user_id: user_id
    }
  end

  def action_type_factory(name) do
    %Crossing.ActionTypes.ActionType{
      name: name
    }
  end

  def action_factory(value, unit, avatar_id, type_id) do
    %Crossing.Actions.Action{
      value: value,
      unit: unit,
      avatar_id: avatar_id,
      action_type_id: type_id
    }
  end
end

# USERS
user1 = Crossing.Repo.insert!(Factory.user_factory())
user2 = Crossing.Repo.insert!(Factory.user_factory())

# COLLECTIONS
Crossing.Repo.insert!(Factory.collection_factory("my faves", user1.id))
Crossing.Repo.insert!(Factory.collection_factory("my closet", user2.id))

# WALLETS
Crossing.Repo.insert!(Factory.wallet_factory(user1.id, 1000.0))
Crossing.Repo.insert!(Factory.wallet_factory(user2.id, 2000.0))

# PROFILES
Crossing.Repo.insert!(Factory.profile_factory(user1.id))
Crossing.Repo.insert!(Factory.profile_factory(user2.id))

# ITEM TYPES
item_type_shirt = Crossing.Repo.insert!(Factory.item_type_factory("shirt"))
item_type_eyewear = Crossing.Repo.insert!(Factory.item_type_factory("eyewear"))
item_type_bottoms = Crossing.Repo.insert!(Factory.item_type_factory("bottoms"))
item_type_outerwear = Crossing.Repo.insert!(Factory.item_type_factory("outerwear"))
item_type_accessories = Crossing.Repo.insert!(Factory.item_type_factory("accessories"))

# ITEMS
shirt1 = Crossing.Repo.insert!(Factory.item_factory("shirt1"))
sunglasses1 = Crossing.Repo.insert!(Factory.item_factory("sunglasses1"))
denim1 = Crossing.Repo.insert!(Factory.item_factory("denim1"))
jacket1 = Crossing.Repo.insert!(Factory.item_factory("jacket1"))
earrings1 = Crossing.Repo.insert!(Factory.item_factory("earrings1"))

# ITEM TYPE RELATIONSHIPS
Crossing.Repo.insert!(Factory.item_item_type_factory(shirt1.id, item_type_shirt.id))
Crossing.Repo.insert!(Factory.item_item_type_factory(sunglasses1.id, item_type_eyewear.id))
Crossing.Repo.insert!(Factory.item_item_type_factory(denim1.id, item_type_bottoms.id))
Crossing.Repo.insert!(Factory.item_item_type_factory(jacket1.id, item_type_outerwear.id))
Crossing.Repo.insert!(Factory.item_item_type_factory(earrings1.id, item_type_accessories.id))

# AVATARS
avatar1 = Crossing.Repo.insert!(Factory.avatar_factory(user1.id))
avatar2 = Crossing.Repo.insert!(Factory.avatar_factory(user2.id))

# ACTION TYPES
action_type_hours_asleep = Crossing.Repo.insert!(Factory.action_type_factory("hoursAsleep"))
action_type_running = Crossing.Repo.insert!(Factory.action_type_factory("running"))
action_type_yoga = Crossing.Repo.insert!(Factory.action_type_factory("yoga"))
action_type_exercise = Crossing.Repo.insert!(Factory.action_type_factory("exercise"))
action_type_swimming = Crossing.Repo.insert!(Factory.action_type_factory("swimming"))

# ACTIONS
# Crossing.Repo.insert!(Factory.action_factory(5.0, "", avatar1.id, action_type_running))
