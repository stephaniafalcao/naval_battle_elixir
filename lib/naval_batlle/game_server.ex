defmodule GameServer do
  use GenServer

  def start_board do
    board = NavalBattle.creating_board()
    GenServer.start_link(__MODULE__, %{board: board, count: 5, chances: [], message: "You have 5 chances"})
  end

  def playing(pid, row, column) do
    GenServer.call(pid, {row, column})
  end

  def see_result(pid) do
    GenServer.call(pid, :get)
  end

  def init(state), do: {:ok, state}

  def handle_call(:get, _from, state) do
    {:reply, %{count: state.count, chances: state.chances, message: state.message}, state}
  end

  def handle_call({row, column}, _from, state) when state.count > 0 do
    result = NavalBattle.playing(state.board, row, column)

    count = state.count - 1

    new_state = %{state | count: count, chances: state.chances ++ [%{row: row, column: column, result: result}], message: "You have more #{count} chances"}

    {:reply, %{count: new_state.count, chances: new_state.chances, message: new_state.message}, new_state}
  end

  def handle_call({_row, _column}, _from, state) when state.count == 0 do

    {:reply, %{state | message: "Game over. No more chances"}, state}
  end
end
