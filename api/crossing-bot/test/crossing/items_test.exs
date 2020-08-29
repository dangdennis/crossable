defmodule Crossing.ItemsTest do
  use Crossing.DataCase

  alias Crossing.Items

  describe "items" do
    alias Crossing.Items.Item

    @valid_attrs %{deleted_at: "2010-04-17T14:00:00Z", image_url: "some image_url", name: "some name", type: "some type"}
    @update_attrs %{deleted_at: "2011-05-18T15:01:01Z", image_url: "some updated image_url", name: "some updated name", type: "some updated type"}
    @invalid_attrs %{deleted_at: nil, image_url: nil, name: nil, type: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Items.create_item(@valid_attrs)
      assert item.deleted_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert item.image_url == "some image_url"
      assert item.name == "some name"
      assert item.type == "some type"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Items.update_item(item, @update_attrs)
      assert item.deleted_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert item.image_url == "some updated image_url"
      assert item.name == "some updated name"
      assert item.type == "some updated type"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
