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
    name: "Arthas Menethil, The Lich King",
    image_url:
      "https://cdn.vox-cdn.com/thumbor/k6m7tw54mdYa2yJoYbk3FuIYFZg=/0x0:1024x576/1920x0/filters:focal(0x0:1024x576):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/19748343/155054_the_lich_king.jpg"
  })

boss_2 =
  Crossing.Repo.insert!(%Crossing.Raids.RaidBoss{
    name: "The Alien Queen",
    image_url:
      "https://vignette.wikia.nocookie.net/avp/images/7/74/Promo07.PNG/revision/latest?cb=20120527102557"
  })

# RAIDS
raid_1_inactive =
  Crossing.Repo.insert!(%Crossing.Raids.Raid{
    active: false,
    completion_percentage: 1.0,
    start_time: Timex.now() |> DateTime.truncate(:second),
    end_time: DateTime.add(Timex.now(), 60 * 60 * 24, :second) |> DateTime.truncate(:second),
    raid_boss_id: boss_1.id
  })

raid_2_active =
  Crossing.Repo.insert!(%Crossing.Raids.Raid{
    active: true,
    start_time: Timex.now() |> DateTime.truncate(:second),
    end_time: DateTime.add(Timex.now(), 604_800, :second) |> DateTime.truncate(:second),
    raid_boss_id: boss_2.id,
    completion_percentage: 0.0
  })

# RAID MEMBERS
Crossing.Repo.insert!(%Crossing.Raids.RaidMember{
  active: true,
  user_id: user1.id,
  raid_id: raid_1_inactive.id,
  status: "completed"
})

Crossing.Repo.insert!(%Crossing.Raids.RaidMember{
  active: true,
  user_id: user2.id,
  raid_id: raid_1_inactive.id,
  status: "completed"
})

Crossing.Repo.insert!(%Crossing.Raids.RaidMember{
  active: true,
  user_id: user1.id,
  raid_id: raid_2_active.id,
  # "attacked"
  status: "ready"
})

Crossing.Repo.insert!(%Crossing.Raids.RaidMember{
  active: true,
  user_id: user2.id,
  raid_id: raid_2_active.id,
  # "attacked"
  status: "ready"
})
