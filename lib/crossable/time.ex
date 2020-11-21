defmodule Crossable.Time do
  @moduledoc """
  Crossable time helpers.
  """

  def run_at_time(now_time, run_time, callback) do
    case Time.compare(now_time, run_time) do
      :lt ->
        false

      :eq ->
        callback.()
        true

      :gt ->
        callback.()
        true
    end
  end
end
