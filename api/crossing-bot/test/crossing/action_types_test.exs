defmodule Crossing.ActionTypesTest do
  use Crossing.DataCase

  alias Crossing.ActionTypes

  describe "action_types" do
    alias Crossing.ActionTypes.ActionType

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def action_type_fixture(attrs \\ %{}) do
      {:ok, action_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ActionTypes.create_action_type()

      action_type
    end

    test "list_action_types/0 returns all action_types" do
      action_type = action_type_fixture()
      assert ActionTypes.list_action_types() == [action_type]
    end

    test "get_action_type!/1 returns the action_type with given id" do
      action_type = action_type_fixture()
      assert ActionTypes.get_action_type!(action_type.id) == action_type
    end

    test "create_action_type/1 with valid data creates a action_type" do
      assert {:ok, %ActionType{} = action_type} = ActionTypes.create_action_type(@valid_attrs)
      assert action_type.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert action_type.name == "some name"
    end

    test "create_action_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ActionTypes.create_action_type(@invalid_attrs)
    end

    test "update_action_type/2 with valid data updates the action_type" do
      action_type = action_type_fixture()
      assert {:ok, %ActionType{} = action_type} = ActionTypes.update_action_type(action_type, @update_attrs)
      assert action_type.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert action_type.name == "some updated name"
    end

    test "update_action_type/2 with invalid data returns error changeset" do
      action_type = action_type_fixture()
      assert {:error, %Ecto.Changeset{}} = ActionTypes.update_action_type(action_type, @invalid_attrs)
      assert action_type == ActionTypes.get_action_type!(action_type.id)
    end

    test "delete_action_type/1 deletes the action_type" do
      action_type = action_type_fixture()
      assert {:ok, %ActionType{}} = ActionTypes.delete_action_type(action_type)
      assert_raise Ecto.NoResultsError, fn -> ActionTypes.get_action_type!(action_type.id) end
    end

    test "change_action_type/1 returns a action_type changeset" do
      action_type = action_type_fixture()
      assert %Ecto.Changeset{} = ActionTypes.change_action_type(action_type)
    end
  end
end
