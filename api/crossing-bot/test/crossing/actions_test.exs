defmodule Crossing.ActionsTest do
  use Crossing.DataCase

  alias Crossing.Actions

  describe "actions" do
    alias Crossing.Actions.Action

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def action_fixture(attrs \\ %{}) do
      {:ok, action} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actions.create_action()

      action
    end

    test "list_actions/0 returns all actions" do
      action = action_fixture()
      assert Actions.list_actions() == [action]
    end

    test "get_action!/1 returns the action with given id" do
      action = action_fixture()
      assert Actions.get_action!(action.id) == action
    end

    test "create_action/1 with valid data creates a action" do
      assert {:ok, %Action{} = action} = Actions.create_action(@valid_attrs)
      assert action.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert action.name == "some name"
    end

    test "create_action/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actions.create_action(@invalid_attrs)
    end

    test "update_action/2 with valid data updates the action" do
      action = action_fixture()
      assert {:ok, %Action{} = action} = Actions.update_action(action, @update_attrs)
      assert action.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert action.name == "some updated name"
    end

    test "update_action/2 with invalid data returns error changeset" do
      action = action_fixture()
      assert {:error, %Ecto.Changeset{}} = Actions.update_action(action, @invalid_attrs)
      assert action == Actions.get_action!(action.id)
    end

    test "delete_action/1 deletes the action" do
      action = action_fixture()
      assert {:ok, %Action{}} = Actions.delete_action(action)
      assert_raise Ecto.NoResultsError, fn -> Actions.get_action!(action.id) end
    end

    test "change_action/1 returns a action changeset" do
      action = action_fixture()
      assert %Ecto.Changeset{} = Actions.change_action(action)
    end
  end

  describe "action_types" do
    alias Crossing.Actions.ActionType

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def action_type_fixture(attrs \\ %{}) do
      {:ok, action_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actions.create_action_type()

      action_type
    end

    test "list_action_types/0 returns all action_types" do
      action_type = action_type_fixture()
      assert Actions.list_action_types() == [action_type]
    end

    test "get_action_type!/1 returns the action_type with given id" do
      action_type = action_type_fixture()
      assert Actions.get_action_type!(action_type.id) == action_type
    end

    test "create_action_type/1 with valid data creates a action_type" do
      assert {:ok, %ActionType{} = action_type} = Actions.create_action_type(@valid_attrs)
      assert action_type.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert action_type.name == "some name"
    end

    test "create_action_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actions.create_action_type(@invalid_attrs)
    end

    test "update_action_type/2 with valid data updates the action_type" do
      action_type = action_type_fixture()
      assert {:ok, %ActionType{} = action_type} = Actions.update_action_type(action_type, @update_attrs)
      assert action_type.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert action_type.name == "some updated name"
    end

    test "update_action_type/2 with invalid data returns error changeset" do
      action_type = action_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Actions.update_action_type(action_type, @invalid_attrs)
      assert action_type == Actions.get_action_type!(action_type.id)
    end

    test "delete_action_type/1 deletes the action_type" do
      action_type = action_type_fixture()
      assert {:ok, %ActionType{}} = Actions.delete_action_type(action_type)
      assert_raise Ecto.NoResultsError, fn -> Actions.get_action_type!(action_type.id) end
    end

    test "change_action_type/1 returns a action_type changeset" do
      action_type = action_type_fixture()
      assert %Ecto.Changeset{} = Actions.change_action_type(action_type)
    end
  end
end
