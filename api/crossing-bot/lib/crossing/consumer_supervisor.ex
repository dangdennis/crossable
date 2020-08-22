defmodule Crossing.ConsumerSupervisor do
  @moduledoc """
  Supervises Crossing's consumers.

  Crossing spawns one consumer per online scheduler at startup,
  which means one consumer per CPU core in the default ERTS settings.
  """

  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    children =
      for n <- 1..System.schedulers_online(),
          do: Supervisor.child_spec({Crossing.Consumer, []}, id: {:crossing, :consumer, n})

    Supervisor.init(children, strategy: :one_for_one)
  end
end
