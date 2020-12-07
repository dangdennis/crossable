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

      assert {:ok, _dialog_msg} =
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

      {:ok, _dialog_msg} =
        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow.id,
          sequence_position: 1,
          content: "huehuehue"
        })

      assert {:ok, _channel_dialog_flow} =
               Crossable.Dialogs.assign_dialog_flow_to_channel(
                 "12341241",
                 dialog_flow.id
               )
    end
  end

  describe "Crossable.Dialogs.get_dialog_message/1" do
    test "finds a single dialog message for a sequence without a response match" do
      {:ok, dm} =
        Crossable.Dialogs.get_dialog_message(%{
          dialog_flow_id: 1,
          sequence_position: 1
        })

      assert dm.content ==
               "Howdy! I’m your friendly CrossBot partner and I’ll be doing a daily checking with you for the next 30 days!"
    end

    test "finds a single dialog message for a sequence with a yes response match" do
      {:ok, dm} =
        Crossable.Dialogs.get_dialog_message(%{
          dialog_flow_id: 1,
          sequence_position: 1,
          response_match: "yes"
        })

      assert dm.content == "Awesome!"
    end

    test "finds a single dialog message for a sequence with a no response match" do
      {:ok, dm} =
        Crossable.Dialogs.get_dialog_message(%{
          dialog_flow_id: 1,
          sequence_position: 1,
          response_match: "no"
        })

      assert dm.content ==
               "Drop a message in the #ask-the-team channel and one of our team (Human) will answer your question as soon as possible. Thanks!"
    end

    test "should return an :error with a reason if missing" do
      assert {:error, _} =
               Crossable.Dialogs.get_dialog_message(%{
                 dialog_flow_id: 1,
                 sequence_position: 999
               })
    end
  end

  describe "Crossable.Dialogs.increment_dialog_sequence/1" do
    test "should increment dialog sequence by one" do
      {:ok, dialog_flow} = Crossable.Dialogs.create_dialog_flow(%{name: "random name"})

      {:ok, channel_dialog_flow} =
        Crossable.Dialogs.assign_dialog_flow_to_channel(
          "12341241",
          dialog_flow.id
        )

      {:ok, updated_cdf} = Crossable.Dialogs.increment_dialog_sequence(channel_dialog_flow)
      assert updated_cdf.sequence_position == 2
    end
  end
end
