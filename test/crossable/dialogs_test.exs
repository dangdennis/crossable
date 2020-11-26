defmodule Crossable.DialogsTest do
  use Crossable.DataCase

  describe "Crossable.Dialogs.create_dialog_flow/1" do
    test "successfully creates a new dialog flow" do
      dialog_name = "30 day something"
      assert {:ok, dialog_flow} = Crossable.Dialogs.create_dialog_flow(%{name: dialog_name})
      assert dialog_flow.name === dialog_name
    end
  end

  describe "Crossable.Dialogs.create_dialog_message/1" do
    test "successfully creates a new dialog flow" do
      {:ok, dialog_flow} = Crossable.Dialogs.create_dialog_flow(%{name: "30 day something"})

      assert {:ok, dialog_msg} =
               Crossable.Dialogs.create_dialog_message(%{
                 dialog_flow_id: dialog_flow.id,
                 sequence_position: 1,
                 content: "huehuehue"
               })
    end
  end

  describe "Crossable.Dialogs.assign_dialog_flow_to_channel/2" do
    test "sucessfully assign dialog flow" do
      {:ok, dialog_flow} = Crossable.Dialogs.create_dialog_flow(%{name: "random flow"})

      {:ok, dialog_msg} =
        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow.id,
          sequence_position: 1,
          content: "huehuehue"
        })

      assert {:ok, channel_dialog_flow} =
               Crossable.Dialogs.assign_dialog_flow_to_channel(
                 "12341241",
                 dialog_flow.id
               )
    end
  end
end
