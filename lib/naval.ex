defmodule NavalBattle do
  use GenServer

  def init(state), do: {:ok, state}

  def start_board() do
    board = creatingBoard()
    GenServer.start_link(__MODULE__, %{board: board, count: 5, chances: []})
  end

  def handle_call(:get, _from, state) do
    {:reply, %{count: state.count, chances: state.chances}, state}
  end

  def handle_cast({row,column}, state) do
    result = state.board
    |> Map.get(row)
    |> Map.get(column)
    |> printResult

    {:noreply, %{state | count: state.count - 1, chances: state.chances ++ [%{row: row, column: column, result: result}]}}
  end

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

  def playing1(pid, row, column) do
    GenServer.cast(pid, {row, column})
  end


  defp definingPositions do
    values = [0, 1]

    line =
      Enum.map(1..10, fn x ->
        {x, Enum.random(values)}
      end)

    Map.new(line)
  end

  defp printResult(1), do: true
  defp printResult(0), do: false

  def see_result(pid) do
    GenServer.call(pid, :get)
  end

  def update_board() do
    GenServer.call(__MODULE__, :update_board)
  end
end
