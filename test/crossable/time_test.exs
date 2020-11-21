defmodule Crossable.TimeTest do
  use Crossable.DataCase

  describe "Crossable.Time.run_once_within_hour/3" do
    test "should execute callback if time is gt or eq to desired time, and only within that hour" do
      assert true ==
               Crossable.Time.run_once_within_hour(~T[18:00:00], ~T[18:00:00], fn -> nil end)

      assert true ==
               Crossable.Time.run_once_within_hour(~T[18:00:01], ~T[18:00:00], fn -> nil end)

      assert true ==
               Crossable.Time.run_once_within_hour(~T[18:59:58], ~T[18:00:00], fn -> nil end)

      assert false ==
               Crossable.Time.run_once_within_hour(~T[19:00:00], ~T[18:00:00], fn -> nil end)

      assert false ==
               Crossable.Time.run_once_within_hour(~T[17:00:00], ~T[18:00:00], fn -> nil end)

      assert false ==
               Crossable.Time.run_once_within_hour(~T[17:59:59], ~T[18:00:00], fn -> nil end)
    end
  end
end
