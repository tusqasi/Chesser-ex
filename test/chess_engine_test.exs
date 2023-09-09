defmodule ChessEngineTest do
  use ExUnit.Case
  doctest ChessEngine

  test "Generate a standard board" do
    assert ChessEngine.init_standard_board() ==
      %ChessEngine.Board{
        board: [
          "r",
          "n",
          "b",
          "q",
          "k",
          "b",
          "n",
          "r",
          "p",
          "p",
          "p",
          "p",
          "p",
          "p",
          "p",
          "p",
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          :empty,
          "P",
          "P",
          "P",
          "P",
          "P",
          "P",
          "P",
          "P",
          "R",
          "N",
          "B",
          "Q",
          "K",
          "B",
          "N",
          "R"
        ]
      }
  end
  test "Empty PGN string" do
    assert ChessEngine.board_from_pgn("")  == %ChessEngine.Board{}
  end
end
