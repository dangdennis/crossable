defmodule Crossing.Commands.Raid do
  alias Crossing.Raids

  def invoke(msg) do
    _raid = Raids.get_active_raid()
    Nostrum.Api.create_message!(msg.channel_id, "Active raid is...")
  end
end
