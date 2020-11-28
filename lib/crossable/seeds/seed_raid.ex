defmodule Crossable.Seeds.Raids do
  @moduledoc """
  Seed data for the raid feature.
  """
  require Ecto.Query
  require Logger

  def run() do
    Faker.start()

    # # USERS
    Crossable.Users.create_user(%{
      discord_user_id: System.unique_integer([:positive]) |> Integer.to_string(),
      avatar: %{}
    })

    Crossable.Users.create_user(%{
      discord_user_id: System.unique_integer([:positive]) |> Integer.to_string(),
      avatar: %{}
    })

    # RAID BOSSES

    case %Crossable.Schema.Raids.RaidBoss{}
         |> Crossable.Schema.Raids.RaidBoss.changeset(%{
           name: "Arthas Menethil, The Lich King",
           image_url:
             "https://cdn.vox-cdn.com/thumbor/k6m7tw54mdYa2yJoYbk3FuIYFZg=/0x0:1024x576/1920x0/filters:focal(0x0:1024x576):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/19748343/155054_the_lich_king.jpg"
         })
         |> Crossable.Repo.insert() do
      {:ok, boss_1} ->
        %Crossable.Schema.Raids.Raid{}
        |> Crossable.Schema.Raids.Raid.changeset(%{
          active: false,
          completion_percentage: 1.0,
          start_time: Timex.now() |> DateTime.truncate(:second),
          end_time:
            DateTime.add(Timex.now(), 60 * 60 * 24, :second) |> DateTime.truncate(:second),
          raid_boss_id: boss_1.id
        })
        |> Crossable.Repo.insert()

        %Crossable.Schema.Raids.Raid{}

        %Crossable.Schema.Raids.Raid{}
        |> Crossable.Schema.Raids.Raid.changeset(%{
          active: false,
          completion_percentage: 1.0,
          start_time: Timex.now() |> DateTime.truncate(:second),
          end_time:
            DateTime.add(Timex.now(), 60 * 60 * 24, :second) |> DateTime.truncate(:second),
          raid_boss_id: boss_1.id
        })
        |> Crossable.Repo.insert()

      {:error, _} ->
        Logger.info("raid boss already exists")
    end

    _ =
      %Crossable.Schema.Raids.RaidBoss{}
      |> Crossable.Schema.Raids.RaidBoss.changeset(%{
        name: "The Alien Queen",
        image_url:
          "https://vignette.wikia.nocookie.net/avp/images/7/74/Promo07.PNG/revision/latest?cb=20120527102557"
      })
      |> Crossable.Repo.insert()

    # RAIDS

    # RAID MEMBERS
    # Crossable.Users.list_users()
    # |> Enum.each(fn user ->
    #   Crossable.Repo.insert!(%Crossable.Schema.Raids.RaidMember{
    #     active: true,
    #     avatar_id: user.avatar.id,
    #     raid_id: raid_1_inactive.id,
    #     status: "completed"
    #   })

    #   Crossable.Repo.insert!(%Crossable.Schema.Raids.RaidMember{
    #     active: true,
    #     avatar_id: user.avatar.id,
    #     raid_id: raid_2_active.id,
    #     status: "ready"
    #   })
    # end)
  end
end
