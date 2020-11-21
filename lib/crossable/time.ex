defmodule Crossable.Time do
  @moduledoc """
  Crossable time helpers.
  """

  @doc """
  Runs the callback only if the given time is within the same hour as the runtime
  """
  def run_once_within_hour(current_time, run_time, callback) do
    # lower bound: current time is greater than or equal to the desired runtime
    # upper bound: current time is less than to 1 hour after the desired runtime
    case {Time.compare(current_time, run_time),
          Time.compare(current_time, Time.add(run_time, 60 * 59 + 59) |> Time.truncate(:second))} do
      {:eq, :lt} ->
        callback.()
        true

      {:eq, :eq} ->
        callback.()
        true

      {:gt, :lt} ->
        callback.()
        true

      {:gt, :eq} ->
        callback.()
        true

      {_, _} ->
        false
    end
  end
end
