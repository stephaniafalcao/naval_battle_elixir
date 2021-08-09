defmodule NavalBatlle.GameServerTest do
  use ExUnit.Case, async: true

  test "start_board/0 creates a valid game" do
    {:ok, pid} = GameServer.start_board()

    assert GameServer.see_result(pid) == %{chances: [], count: 5, message: "You have 5 chances"}
  end

  test "playing/3 play with valid attempt => shot" do
    create_board_engine = fn -> %{1 => %{1 => 1}}  end
    {:ok, pid} = GameServer.start_board(create_board_engine)

    result_play = GameServer.playing(pid, 1, 1)

    assert result_play.chances ==  [%{row: 1, column: 1, result: :shot}]
  end

  test "playing/3 play with valid attempt => water" do
    create_board_engine = fn -> %{1 => %{1 => 0}}  end
    {:ok, pid} = GameServer.start_board(create_board_engine)

    result_play = GameServer.playing(pid, 1, 1)

    assert result_play.chances ==  [%{row: 1, column: 1, result: :water}]
  end

  test "playing/3 play with invalid attempt"

  test "see_result/1 see result after 3 attempts"
end
