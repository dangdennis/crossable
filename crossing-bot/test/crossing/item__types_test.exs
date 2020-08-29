defmodule Crossing.Item_TypesTest do
  use Crossing.DataCase

  alias Crossing.Item_Types

  describe "item_types" do
    alias Crossing.Item_Types.Item_Type

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def item__type_fixture(attrs \\ %{}) do
      {:ok, item__type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Item_Types.create_item__type()

      item__type
    end

    test "list_item_types/0 returns all item_types" do
      item__type = item__type_fixture()
      assert Item_Types.list_item_types() == [item__type]
    end

    test "get_item__type!/1 returns the item__type with given id" do
      item__type = item__type_fixture()
      assert Item_Types.get_item__type!(item__type.id) == item__type
    end

    test "create_item__type/1 with valid data creates a item__type" do
      assert {:ok, %Item_Type{} = item__type} = Item_Types.create_item__type(@valid_attrs)
      assert item__type.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert item__type.name == "some name"
    end

    test "create_item__type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Item_Types.create_item__type(@invalid_attrs)
    end

    test "update_item__type/2 with valid data updates the item__type" do
      item__type = item__type_fixture()
      assert {:ok, %Item_Type{} = item__type} = Item_Types.update_item__type(item__type, @update_attrs)
      assert item__type.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert item__type.name == "some updated name"
    end

    test "update_item__type/2 with invalid data returns error changeset" do
      item__type = item__type_fixture()
      assert {:error, %Ecto.Changeset{}} = Item_Types.update_item__type(item__type, @invalid_attrs)
      assert item__type == Item_Types.get_item__type!(item__type.id)
    end

    test "delete_item__type/1 deletes the item__type" do
      item__type = item__type_fixture()
      assert {:ok, %Item_Type{}} = Item_Types.delete_item__type(item__type)
      assert_raise Ecto.NoResultsError, fn -> Item_Types.get_item__type!(item__type.id) end
    end

    test "change_item__type/1 returns a item__type changeset" do
      item__type = item__type_fixture()
      assert %Ecto.Changeset{} = Item_Types.change_item__type(item__type)
    end
  end
end
