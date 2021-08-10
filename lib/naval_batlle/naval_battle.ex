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
    case validatePositions(board, row, column) do
      :ok ->
        result = board
          |> Map.get(row)
          |> Map.get(column)
          |> print_result

          {:ok, result}
      {:error, message} ->
        {:error, message}
    end
  end

  defp validatePositions(board, row, column) do
    board_length = length(Map.keys(board))

    if (row > 0 and row <= board_length) and (column > 0 and column <= board_length) do
      :ok
    else
      {:error, "Invalid positions passed. Positions should be between 1 and #{board_length}"}
    end
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
