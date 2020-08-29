defmodule Crossing.ItemItemTypesTest do
  use Crossing.DataCase

  alias Crossing.ItemItemTypes

  describe "item_item_types" do
    alias Crossing.ItemItemTypes.ItemItemType

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{deleted_at: nil}

    def item_item_type_fixture(attrs \\ %{}) do
      {:ok, item_item_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ItemItemTypes.create_item_item_type()

      item_item_type
    end

    test "list_item_item_types/0 returns all item_item_types" do
      item_item_type = item_item_type_fixture()
      assert ItemItemTypes.list_item_item_types() == [item_item_type]
    end

    test "get_item_item_type!/1 returns the item_item_type with given id" do
      item_item_type = item_item_type_fixture()
      assert ItemItemTypes.get_item_item_type!(item_item_type.id) == item_item_type
    end

    test "create_item_item_type/1 with valid data creates a item_item_type" do
      assert {:ok, %ItemItemType{} = item_item_type} = ItemItemTypes.create_item_item_type(@valid_attrs)
      assert item_item_type.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_item_item_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ItemItemTypes.create_item_item_type(@invalid_attrs)
    end

    test "update_item_item_type/2 with valid data updates the item_item_type" do
      item_item_type = item_item_type_fixture()
      assert {:ok, %ItemItemType{} = item_item_type} = ItemItemTypes.update_item_item_type(item_item_type, @update_attrs)
      assert item_item_type.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_item_item_type/2 with invalid data returns error changeset" do
      item_item_type = item_item_type_fixture()
      assert {:error, %Ecto.Changeset{}} = ItemItemTypes.update_item_item_type(item_item_type, @invalid_attrs)
      assert item_item_type == ItemItemTypes.get_item_item_type!(item_item_type.id)
    end

    test "delete_item_item_type/1 deletes the item_item_type" do
      item_item_type = item_item_type_fixture()
      assert {:ok, %ItemItemType{}} = ItemItemTypes.delete_item_item_type(item_item_type)
      assert_raise Ecto.NoResultsError, fn -> ItemItemTypes.get_item_item_type!(item_item_type.id) end
    end

    test "change_item_item_type/1 returns a item_item_type changeset" do
      item_item_type = item_item_type_fixture()
      assert %Ecto.Changeset{} = ItemItemTypes.change_item_item_type(item_item_type)
    end
  end
end
