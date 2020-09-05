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
user1 =
  Crossing.Repo.insert!(%Crossing.Users.User{
    discord_user_id: System.unique_integer([:positive]) |> Integer.to_string()
  })

user2 =
  Crossing.Repo.insert!(%Crossing.Users.User{
    discord_user_id: System.unique_integer([:positive]) |> Integer.to_string()
  })

# RAID BOSSES
boss_1 =
  Crossing.Repo.insert!(%Crossing.Raids.RaidBoss{
    name: "Alien Queen",
    image_url:
      "https://vignette.wikia.nocookie.net/avp/images/7/74/Promo07.PNG/revision/latest?cb=20120527102557"
  })

boss_2 =
  Crossing.Repo.insert!(%Crossing.Raids.RaidBoss{
    name: "Arthas Menethil, The Lich King",
    image_url:
      "https://cdn.vox-cdn.com/thumbor/k6m7tw54mdYa2yJoYbk3FuIYFZg=/0x0:1024x576/1920x0/filters:focal(0x0:1024x576):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/19748343/155054_the_lich_king.jpg"
  })

# AVATARS

# avatar1 = Crossing.Repo.insert!(Factory.build(:avatar))
# avatar2 = Crossing.Repo.insert!(Factory.build(:avatar))
