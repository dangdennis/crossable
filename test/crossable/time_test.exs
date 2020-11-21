defmodule Crossable.TimeTest do
  use Crossable.DataCase

  describe "Crossable.Time.run_at_time/3" do
    test "should execute callback if time is gt or eq to desired time" do
      assert true ==
               Crossable.Time.run_at_time(~T[18:00:00], ~T[18:00:00], fn ->
                 nil
               end)

      assert true ==
               Crossable.Time.run_at_time(~T[18:00:01], ~T[18:00:00], fn ->
                 nil
               end)

      assert false ==
               Crossable.Time.run_at_time(~T[17:00:00], ~T[18:00:00], fn ->
                 nil
               end)

      assert false ==
               Crossable.Time.run_at_time(~T[17:59:59], ~T[18:00:00], fn ->
                 nil
               end)
    end
  end
end
