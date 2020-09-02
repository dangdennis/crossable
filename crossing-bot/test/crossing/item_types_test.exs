defmodule Crossing.ItemTypesTest do
  use Crossing.DataCase

  alias Crossing.ItemTypes

  describe "item_types" do
    alias Crossing.Items.ItemType

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def item_type_fixture(attrs \\ %{}) do
      {:ok, item_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ItemTypes.create_item_type()

      item_type
    end

    test "list_item_types/0 returns all item_types" do
      item_type = item_type_fixture()
      assert ItemTypes.list_item_types() == [item_type]
    end

    test "get_item_type!/1 returns the item_type with given id" do
      item_type = item_type_fixture()
      assert ItemTypes.get_item_type!(item_type.id) == item_type
    end

    test "create_item_type/1 with valid data creates a item_type" do
      assert {:ok, %ItemType{} = item_type} = ItemTypes.create_item_type(@valid_attrs)
      assert item_type.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert item_type.name == "some name"
    end

    test "create_item_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ItemTypes.create_item_type(@invalid_attrs)
    end

    test "update_item_type/2 with valid data updates the item_type" do
      item_type = item_type_fixture()
      assert {:ok, %ItemType{} = item_type} = ItemTypes.update_item_type(item_type, @update_attrs)
      assert item_type.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert item_type.name == "some updated name"
    end

    test "update_item_type/2 with invalid data returns error changeset" do
      item_type = item_type_fixture()
      assert {:error, %Ecto.Changeset{}} = ItemTypes.update_item_type(item_type, @invalid_attrs)
      assert item_type == ItemTypes.get_item_type!(item_type.id)
    end

    test "delete_item_type/1 deletes the item_type" do
      item_type = item_type_fixture()
      assert {:ok, %ItemType{}} = ItemTypes.delete_item_type(item_type)
      assert_raise Ecto.NoResultsError, fn -> ItemTypes.get_item_type!(item_type.id) end
    end

    test "change_item_type/1 returns a item_type changeset" do
      item_type = item_type_fixture()
      assert %Ecto.Changeset{} = ItemTypes.change_item_type(item_type)
    end
  end
end
