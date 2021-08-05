defmodule NavalBatlle.GameServerTest do
  use ExUnit.Case

  test "start_board/0 creates a valid game" do
    {:ok, pid} = GameServer.start_board()

    assert GameServer.see_result(pid) == %{chances: [], count: 5, message: "You have 5 chances"}
  end
end
