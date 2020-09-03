# defmodule Crossing.RaidsTest do
#   use Crossing.DataCase

#   alias Crossing.Raids

#   describe "raid_bosses" do
#     alias Crossing.Raids.RaidBoss

#     @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", image_url: "some image_url", name: "some name"}
#     @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", image_url: "some updated image_url", name: "some updated name"}
#     @invalid_attrs %{deleted_at: nil, image_url: nil, name: nil}

#     def raid_boss_fixture(attrs \\ %{}) do
#       {:ok, raid_boss} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Raids.create_raid_boss()

#       raid_boss
#     end

#     test "list_raid_bosses/0 returns all raid_bosses" do
#       raid_boss = raid_boss_fixture()
#       assert Raids.list_raid_bosses() == [raid_boss]
#     end

#     test "get_raid_boss!/1 returns the raid_boss with given id" do
#       raid_boss = raid_boss_fixture()
#       assert Raids.get_raid_boss!(raid_boss.id) == raid_boss
#     end

#     test "create_raid_boss/1 with valid data creates a raid_boss" do
#       assert {:ok, %RaidBoss{} = raid_boss} = Raids.create_raid_boss(@valid_attrs)
#       assert raid_boss.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#       assert raid_boss.image_url == "some image_url"
#       assert raid_boss.name == "some name"
#     end

#     test "create_raid_boss/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Raids.create_raid_boss(@invalid_attrs)
#     end

#     test "update_raid_boss/2 with valid data updates the raid_boss" do
#       raid_boss = raid_boss_fixture()
#       assert {:ok, %RaidBoss{} = raid_boss} = Raids.update_raid_boss(raid_boss, @update_attrs)
#       assert raid_boss.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#       assert raid_boss.image_url == "some updated image_url"
#       assert raid_boss.name == "some updated name"
#     end

#     test "update_raid_boss/2 with invalid data returns error changeset" do
#       raid_boss = raid_boss_fixture()
#       assert {:error, %Ecto.Changeset{}} = Raids.update_raid_boss(raid_boss, @invalid_attrs)
#       assert raid_boss == Raids.get_raid_boss!(raid_boss.id)
#     end

#     test "delete_raid_boss/1 deletes the raid_boss" do
#       raid_boss = raid_boss_fixture()
#       assert {:ok, %RaidBoss{}} = Raids.delete_raid_boss(raid_boss)
#       assert_raise Ecto.NoResultsError, fn -> Raids.get_raid_boss!(raid_boss.id) end
#     end

#     test "change_raid_boss/1 returns a raid_boss changeset" do
#       raid_boss = raid_boss_fixture()
#       assert %Ecto.Changeset{} = Raids.change_raid_boss(raid_boss)
#     end
#   end

#   describe "raids" do
#     alias Crossing.Raids.Raid

#     @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", end_time: "2010-04-17T14:00:00Z", player_limit: 42, status: "some status"}
#     @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", end_time: "2011-05-18T15:01:01Z", player_limit: 43, status: "some updated status"}
#     @invalid_attrs %{deleted_at: nil, end_time: nil, player_limit: nil, status: nil}

#     def raid_fixture(attrs \\ %{}) do
#       {:ok, raid} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Raids.create_raid()

#       raid
#     end

#     test "list_raids/0 returns all raids" do
#       raid = raid_fixture()
#       assert Raids.list_raids() == [raid]
#     end

#     test "get_raid!/1 returns the raid with given id" do
#       raid = raid_fixture()
#       assert Raids.get_raid!(raid.id) == raid
#     end

#     test "create_raid/1 with valid data creates a raid" do
#       assert {:ok, %Raid{} = raid} = Raids.create_raid(@valid_attrs)
#       assert raid.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#       assert raid.end_time == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#       assert raid.player_limit == 42
#       assert raid.status == "some status"
#     end

#     test "create_raid/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Raids.create_raid(@invalid_attrs)
#     end

#     test "update_raid/2 with valid data updates the raid" do
#       raid = raid_fixture()
#       assert {:ok, %Raid{} = raid} = Raids.update_raid(raid, @update_attrs)
#       assert raid.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#       assert raid.end_time == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#       assert raid.player_limit == 43
#       assert raid.status == "some updated status"
#     end

#     test "update_raid/2 with invalid data returns error changeset" do
#       raid = raid_fixture()
#       assert {:error, %Ecto.Changeset{}} = Raids.update_raid(raid, @invalid_attrs)
#       assert raid == Raids.get_raid!(raid.id)
#     end

#     test "delete_raid/1 deletes the raid" do
#       raid = raid_fixture()
#       assert {:ok, %Raid{}} = Raids.delete_raid(raid)
#       assert_raise Ecto.NoResultsError, fn -> Raids.get_raid!(raid.id) end
#     end

#     test "change_raid/1 returns a raid changeset" do
#       raid = raid_fixture()
#       assert %Ecto.Changeset{} = Raids.change_raid(raid)
#     end
#   end

#   describe "raid_members" do
#     alias Crossing.Raids.RaidMember

#     @valid_attrs %{active: true, deleted_at: "2010-04-17T14:00:00Z", status: "some status"}
#     @update_attrs %{active: false, deleted_at: "2011-05-18T15:01:01Z", status: "some updated status"}
#     @invalid_attrs %{active: nil, deleted_at: nil, status: nil}

#     def raid_member_fixture(attrs \\ %{}) do
#       {:ok, raid_member} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Raids.create_raid_member()

#       raid_member
#     end

#     test "list_raid_members/0 returns all raid_members" do
#       raid_member = raid_member_fixture()
#       assert Raids.list_raid_members() == [raid_member]
#     end

#     test "get_raid_member!/1 returns the raid_member with given id" do
#       raid_member = raid_member_fixture()
#       assert Raids.get_raid_member!(raid_member.id) == raid_member
#     end

#     test "create_raid_member/1 with valid data creates a raid_member" do
#       assert {:ok, %RaidMember{} = raid_member} = Raids.create_raid_member(@valid_attrs)
#       assert raid_member.active == true
#       assert raid_member.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#       assert raid_member.status == "some status"
#     end

#     test "create_raid_member/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Raids.create_raid_member(@invalid_attrs)
#     end

#     test "update_raid_member/2 with valid data updates the raid_member" do
#       raid_member = raid_member_fixture()
#       assert {:ok, %RaidMember{} = raid_member} = Raids.update_raid_member(raid_member, @update_attrs)
#       assert raid_member.active == false
#       assert raid_member.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#       assert raid_member.status == "some updated status"
#     end

#     test "update_raid_member/2 with invalid data returns error changeset" do
#       raid_member = raid_member_fixture()
#       assert {:error, %Ecto.Changeset{}} = Raids.update_raid_member(raid_member, @invalid_attrs)
#       assert raid_member == Raids.get_raid_member!(raid_member.id)
#     end

#     test "delete_raid_member/1 deletes the raid_member" do
#       raid_member = raid_member_fixture()
#       assert {:ok, %RaidMember{}} = Raids.delete_raid_member(raid_member)
#       assert_raise Ecto.NoResultsError, fn -> Raids.get_raid_member!(raid_member.id) end
#     end

#     test "change_raid_member/1 returns a raid_member changeset" do
#       raid_member = raid_member_fixture()
#       assert %Ecto.Changeset{} = Raids.change_raid_member(raid_member)
#     end
#   end
# end
