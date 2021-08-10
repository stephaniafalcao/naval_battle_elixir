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

  test "playing/3 play with invalid attempt" do
    create_board_engine = fn -> %{1 => %{1 => 0}}  end
    {:ok, pid} = GameServer.start_board(create_board_engine)

    result_play = GameServer.playing(pid, 2, 1)

    assert result_play == {:error, "Invalid positions passed. Positions should be between 1 and 1"}
  end

  test "see_result/1 see result after 3 attempts" do
    create_board_engine = fn -> %{1 => %{1 => 0, 2 => 1, 3 => 1}, 2 => %{1 => 0, 2 => 1, 3 => 1}, 3 => %{1 => 0, 2 => 1, 3 => 1}}  end
    {:ok, pid} = GameServer.start_board(create_board_engine)

    GameServer.playing(pid, 1, 1)
    GameServer.playing(pid, 1, 2)
    GameServer.playing(pid, 1, 3)

    assert GameServer.see_result(pid) == %{chances: [%{column: 1, result: :water, row: 1}, %{column: 2, result: :shot, row: 1}, %{column: 3, result: :shot, row: 1}], count: 2, message: "You have more 2 chances"}
  end
end
