defmodule NavalBattle do
  def creatingBoard do
    Map.new(
      Enum.map(1..10, fn x ->
        {x, definingPositions()}
      end)
    )
  end

  def playing(board, row, column) do
    board
    |> Map.get(row)
    |> Map.get(column)
    |> printResult
  end

  defp definingPositions do
    values = [0, 1]

    line =
      Enum.map(1..10, fn x ->
        {x, Enum.random(values)}
      end)

    Map.new(line)
  end

  defp printResult(1), do: "You got me"
  defp printResult(0), do: "Keep trying"
end
