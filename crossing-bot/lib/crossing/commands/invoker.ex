defmodule Crossing.Commands.Invoker do
  def handle(msg) do
    IO.inspect(msg)

    case String.split(msg.content, " ", trim: true) do
      ["!new" | _tl] ->
        Crossing.Commands.New.invoke(msg)

      ["!raid" | _tl] ->
        Crossing.Commands.Raid.invoke(msg)

      ["!attack" | _tl] ->
        Crossing.Commands.Attack.invoke(msg)

      _ ->
        nil
    end
  end
end
