defmodule NavalBattle do
  @moduledoc """
  NavalBattle main module
  """
  def creating_board do
    Map.new(
      Enum.map(1..10, fn x ->
        {x, defining_positions()}
      end)
    )
  end

  def playing(board, row, column) do
    board
    |> Map.get(row)
    |> Map.get(column)
    |> print_result
  end

  defp defining_positions do
    values = [0, 1]

    line =
      Enum.map(1..10, fn x ->
        {x, Enum.random(values)}
      end)

    Map.new(line)
  end

  defp print_result(1), do: :shot
  defp print_result(0), do: :water
end
