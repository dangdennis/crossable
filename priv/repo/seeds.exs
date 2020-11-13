# Script for populating the database. You can run it as:

#     mix run priv/repo/seeds.exs

# Inside the script, you can read and write to any of your
# repositories directly:

#     Crossable.Repo.insert!(%Crossable.SomeSchema{})

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
require Ecto.Query

Faker.start()

# # USERS
# Crossable.Users.create_user(%{
#   discord_user_id: System.unique_integer([:positive]) |> Integer.to_string(),
#   avatar: %{}
# })

# Crossable.Users.create_user(%{
#   discord_user_id: System.unique_integer([:positive]) |> Integer.to_string(),
#   avatar: %{}
# })

# RAID BOSSES
# boss_1 =
#   Crossable.Repo.insert!(%Crossable.Raids.RaidBoss{
#     name: "Arthas Menethil, The Lich King",
#     image_url:
#       "https://cdn.vox-cdn.com/thumbor/k6m7tw54mdYa2yJoYbk3FuIYFZg=/0x0:1024x576/1920x0/filters:focal(0x0:1024x576):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/19748343/155054_the_lich_king.jpg"
#   })

# boss_2 =
#   Crossable.Repo.insert!(%Crossable.Raids.RaidBoss{
#     name: "The Alien Queen",
#     image_url:
#       "https://vignette.wikia.nocookie.net/avp/images/7/74/Promo07.PNG/revision/latest?cb=20120527102557"
#   })

# RAIDS
# raid_1_inactive =
#   Crossable.Repo.insert!(%Crossable.Raids.Raid{
#     active: false,
#     completion_percentage: 1.0,
#     start_time: Timex.now() |> DateTime.truncate(:second),
#     end_time: DateTime.add(Timex.now(), 60 * 60 * 24, :second) |> DateTime.truncate(:second),
#     raid_boss_id: boss_1.id
#   })

# raid_2_active =
#   Crossable.Repo.insert!(%Crossable.Raids.Raid{
#     active: true,
#     start_time: Timex.now() |> DateTime.truncate(:second),
#     end_time: DateTime.add(Timex.now(), 604_800, :second) |> DateTime.truncate(:second),
#     raid_boss_id: boss_2.id,
#     completion_percentage: 0.0
#   })

# RAID MEMBERS
# Crossable.Users.list_users()
# |> Enum.each(fn user ->
#   Crossable.Repo.insert!(%Crossable.Raids.RaidMember{
#     active: true,
#     avatar_id: user.avatar.id,
#     raid_id: raid_1_inactive.id,
#     status: "completed"
#   })

#   Crossable.Repo.insert!(%Crossable.Raids.RaidMember{
#     active: true,
#     avatar_id: user.avatar.id,
#     raid_id: raid_2_active.id,
#     status: "ready"
#   })
# end)
