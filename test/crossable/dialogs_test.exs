defmodule Crossable.DialogsTest do
  use Crossable.DataCase

  describe "Crossable.Dialogs.create_dialog_flow/1" do
    test "successfully creates a new dialog flow" do
      dialog_name = "30 day something"
      assert {:ok, dialog_flow} = Crossable.Dialogs.create_dialog_flow(%{name: dialog_name})
      assert dialog_flow.name === dialog_name
    end
  end
end
