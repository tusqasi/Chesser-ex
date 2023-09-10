defmodule ChessEngineTest do
  use ExUnit.Case, async: true
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
    assert ChessEngine.board_from_pgn("") == %ChessEngine.Board{}
  end

  test "Pawn move validation" do
    m = 56

    ChessEngine.valid_moves(m, %ChessEngine.Board{
      board:
        ChessEngine.board_from_pgn("").board
        |> List.replace_at(m, "P")
    })
    |> IO.inspect(charlists: :as_list)
  end

  test "Rook move validation" do
    m = 56

    ChessEngine.valid_moves(m, %ChessEngine.Board{
      board:
        ChessEngine.board_from_pgn("").board
        |> List.replace_at(m, "R")
    })
    |> IO.inspect(charlists: :as_list)
  end

  test "Bishop move validation" do
    m = 17

    ChessEngine.valid_moves(m, %ChessEngine.Board{
      board:
        ChessEngine.board_from_pgn("").board
        |> List.replace_at(m, "B")
    })
    |> IO.inspect(charlists: :as_list)
  end
end
