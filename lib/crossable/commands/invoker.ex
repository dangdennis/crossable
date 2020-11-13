defmodule Crossable.Commands.Invoker do
  def handle(msg) do
    case String.split(msg.content, " ", trim: true) do
      ["!new" | _tl] ->
        Crossable.Commands.New.invoke(msg)

      ["!myhabit" | _tl] ->
        Crossable.Commands.MyHabit.invoke(msg)

      ["!balance" | _tl] ->
        Crossable.Commands.Balance.invoke(msg)

      ["!help" | _tl] ->
        Crossable.Commands.Help.invoke(msg)

      _ ->
        nil
    end
  end
end
