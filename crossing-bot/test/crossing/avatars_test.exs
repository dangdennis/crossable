# defmodule Crossing.AvatarsTest do
#   use Crossing.DataCase

#   alias Crossing.Avatars

#   describe "avatars" do
#     alias Crossing.Avatars.Avatar

#     @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z"}
#     @update_attrs %{deleted_at: "2011-05-18T15:01:01Z"}
#     @invalid_attrs %{deleted_at: nil}

#     def avatar_fixture(attrs \\ %{}) do
#       {:ok, avatar} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Avatars.create_avatar()

#       avatar
#     end

#     test "list_avatars/0 returns all avatars" do
#       avatar = avatar_fixture()
#       assert Avatars.list_avatars() == [avatar]
#     end

#     test "get_avatar!/1 returns the avatar with given id" do
#       avatar = avatar_fixture()
#       assert Avatars.get_avatar!(avatar.id) == avatar
#     end

#     test "create_avatar/1 with valid data creates a avatar" do
#       assert {:ok, %Avatar{} = avatar} = Avatars.create_avatar(@valid_attrs)
#       assert avatar.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#     end

#     test "create_avatar/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Avatars.create_avatar(@invalid_attrs)
#     end

#     test "update_avatar/2 with valid data updates the avatar" do
#       avatar = avatar_fixture()
#       assert {:ok, %Avatar{} = avatar} = Avatars.update_avatar(avatar, @update_attrs)
#       assert avatar.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#     end

#     test "update_avatar/2 with invalid data returns error changeset" do
#       avatar = avatar_fixture()
#       assert {:error, %Ecto.Changeset{}} = Avatars.update_avatar(avatar, @invalid_attrs)
#       assert avatar == Avatars.get_avatar!(avatar.id)
#     end

#     test "delete_avatar/1 deletes the avatar" do
#       avatar = avatar_fixture()
#       assert {:ok, %Avatar{}} = Avatars.delete_avatar(avatar)
#       assert_raise Ecto.NoResultsError, fn -> Avatars.get_avatar!(avatar.id) end
#     end

#     test "change_avatar/1 returns a avatar changeset" do
#       avatar = avatar_fixture()
#       assert %Ecto.Changeset{} = Avatars.change_avatar(avatar)
#     end
#   end
# 
  describe "avatars" do
    alias Crossing.Avatars.Avatar

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{deleted_at: nil}

    def avatar_fixture(attrs \\ %{}) do
      {:ok, avatar} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Avatars.create_avatar()

      avatar
    end

    test "list_avatars/0 returns all avatars" do
      avatar = avatar_fixture()
      assert Avatars.list_avatars() == [avatar]
    end

    test "get_avatar!/1 returns the avatar with given id" do
      avatar = avatar_fixture()
      assert Avatars.get_avatar!(avatar.id) == avatar
    end

    test "create_avatar/1 with valid data creates a avatar" do
      assert {:ok, %Avatar{} = avatar} = Avatars.create_avatar(@valid_attrs)
      assert avatar.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_avatar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Avatars.create_avatar(@invalid_attrs)
    end

    test "update_avatar/2 with valid data updates the avatar" do
      avatar = avatar_fixture()
      assert {:ok, %Avatar{} = avatar} = Avatars.update_avatar(avatar, @update_attrs)
      assert avatar.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_avatar/2 with invalid data returns error changeset" do
      avatar = avatar_fixture()
      assert {:error, %Ecto.Changeset{}} = Avatars.update_avatar(avatar, @invalid_attrs)
      assert avatar == Avatars.get_avatar!(avatar.id)
    end

    test "delete_avatar/1 deletes the avatar" do
      avatar = avatar_fixture()
      assert {:ok, %Avatar{}} = Avatars.delete_avatar(avatar)
      assert_raise Ecto.NoResultsError, fn -> Avatars.get_avatar!(avatar.id) end
    end

    test "change_avatar/1 returns a avatar changeset" do
      avatar = avatar_fixture()
      assert %Ecto.Changeset{} = Avatars.change_avatar(avatar)
    end
  end
end
