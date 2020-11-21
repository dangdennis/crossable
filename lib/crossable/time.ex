defmodule Crossable.Time do
  @moduledoc """
  Crossable time helpers.
  """

  def run_at_time(now_time, run_time, callback) do
    case Time.compare(now_time, run_time) do
      :lt ->
        IO.puts("lt")
        IO.inspect(now_time)
        IO.inspect(run_time)
        false

      :eq ->
        IO.puts("eq")
        IO.inspect(now_time)
        IO.inspect(run_time)
        callback.()
        true

      :gt ->
        IO.puts("gt")
        IO.inspect(now_time)
        IO.inspect(run_time)
        callback.()
        true
    end
  end
end
