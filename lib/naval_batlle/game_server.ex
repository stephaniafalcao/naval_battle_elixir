defmodule GameServer do
  use GenServer

  def playing(pid, row, column) do
    GenServer.cast(pid, {row, column})
  end

  def init(state), do: {:ok, state}

  def start_board() do
    board = NavalBattle.creating_board()
    GenServer.start_link(__MODULE__, %{board: board, count: 5, chances: []})
  end

  def handle_call(:get, _from, state) do
    {:reply, %{count: state.count, chances: state.chances}, state}
  end

  def handle_cast({row,column}, state) do

    result = NavalBattle.playing(state.board, row, column)

    {:noreply, %{state | count: state.count - 1, chances: state.chances ++ [%{row: row, column: column, result: result}]}}
  end

  def see_result(pid) do
    GenServer.call(pid, :get)
  end

end
