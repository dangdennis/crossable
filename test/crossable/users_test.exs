defmodule Crossable.UsersTest do
  use Crossable.DataCase

  alias Crossable.Users

  describe "users" do
    @valid_attrs %{
      discord_user_id: "some discord_user_id",
      username: "some username",
      password_hash: "some password_hash",
      active: true,
      time_zone: "America/New_York",
      avatar: %{user_id: 1},
      deleted_at: "2010-04-17T14:00:00Z"
    }

    # @update_attrs %{
    #   deleted_at: "2011-05-18T15:01:01Z",
    #   discord_user_id: "some updated discord_user_id",
    #   password_hash: "some updated password_hash",
    #   avatar: %{}
    # }
    # @invalid_attrs %{deleted_at: nil, discord_user_id: nil, password_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "list_active_users/0 returns all active users" do
      Users.list_active_users()
      |> Enum.each(fn user ->
        assert user.active == true
      end)
    end

    #     test "get_user!/1 returns the user with given id" do
    #       user = user_fixture()
    #       assert Users.get_user!(user.id) == user
    #     end

    #     test "create_user/1 with valid data creates a user" do
    #       assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
    #       assert user.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    #       assert user.discord_user_id == "some discord_user_id"
    #       assert user.password_hash == "some password_hash"
    #     end

    #     test "create_user/1 with invalid data returns error changeset" do
    #       assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    #     end

    #     test "update_user/2 with valid data updates the user" do
    #       user = user_fixture()
    #       assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
    #       assert user.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    #       assert user.discord_user_id == "some updated discord_user_id"
    #       assert user.password_hash == "some updated password_hash"
    #     end

    #     test "update_user/2 with invalid data returns error changeset" do
    #       user = user_fixture()
    #       assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
    #       assert user == Users.get_user!(user.id)
    #     end

    #     test "delete_user/1 deletes the user" do
    #       user = user_fixture()
    #       assert {:ok, %User{}} = Users.delete_user(user)
    #       assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    #     end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  #   describe "profiles" do
  #     alias Crossable.Schema.Users.Profile

  #     @valid_attrs %{
  #       deleted_at: "2010-04-17T14:00:00Z",
  #       email: "some email",
  #       first_name: "some first_name",
  #       last_name: "some last_name",
  #       phone_number: "some phone_number",
  #       username: "some username"
  #     }
  #     @update_attrs %{
  #       deleted_at: "2011-05-18T15:01:01Z",
  #       email: "some updated email",
  #       first_name: "some updated first_name",
  #       last_name: "some updated last_name",
  #       phone_number: "some updated phone_number",
  #       username: "some updated username"
  #     }
  #     @invalid_attrs %{
  #       deleted_at: nil,
  #       email: nil,
  #       first_name: nil,
  #       last_name: nil,
  #       phone_number: nil,
  #       username: nil
  #     }

  #     def profile_fixture(attrs \\ %{}) do
  #       {:ok, profile} =
  #         attrs
  #         |> Enum.into(@valid_attrs)
  #         |> Users.create_profile()

  #       profile
  #     end

  #     test "list_profiles/0 returns all profiles" do
  #       profile = profile_fixture()
  #       assert Users.list_profiles() == [profile]
  #     end

  #     test "get_profile!/1 returns the profile with given id" do
  #       profile = profile_fixture()
  #       assert Users.get_profile!(profile.id) == profile
  #     end

  #     test "create_profile/1 with valid data creates a profile" do
  #       assert {:ok, %Profile{} = profile} = Users.create_profile(@valid_attrs)
  #       assert profile.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
  #       assert profile.email == "some email"
  #       assert profile.first_name == "some first_name"
  #       assert profile.last_name == "some last_name"
  #       assert profile.phone_number == "some phone_number"
  #       assert profile.username == "some username"
  #     end

  #     test "create_profile/1 with invalid data returns error changeset" do
  #       assert {:error, %Ecto.Changeset{}} = Users.create_profile(@invalid_attrs)
  #     end

  #     test "update_profile/2 with valid data updates the profile" do
  #       profile = profile_fixture()
  #       assert {:ok, %Profile{} = profile} = Users.update_profile(profile, @update_attrs)
  #       assert profile.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
  #       assert profile.email == "some updated email"
  #       assert profile.first_name == "some updated first_name"
  #       assert profile.last_name == "some updated last_name"
  #       assert profile.phone_number == "some updated phone_number"
  #       assert profile.username == "some updated username"
  #     end

  #     test "update_profile/2 with invalid data returns error changeset" do
  #       profile = profile_fixture()
  #       assert {:error, %Ecto.Changeset{}} = Users.update_profile(profile, @invalid_attrs)
  #       assert profile == Users.get_profile!(profile.id)
  #     end

  #     test "delete_profile/1 deletes the profile" do
  #       profile = profile_fixture()
  #       assert {:ok, %Profile{}} = Users.delete_profile(profile)
  #       assert_raise Ecto.NoResultsError, fn -> Users.get_profile!(profile.id) end
  #     end

  #     test "change_profile/1 returns a profile changeset" do
  #       profile = profile_fixture()
  #       assert %Ecto.Changeset{} = Users.change_profile(profile)
  #     end
  #   end
end
