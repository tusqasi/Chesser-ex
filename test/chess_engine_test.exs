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
    assert ChessEngine.board_from_pgn("") == %ChessEngine.Board{}
  end

  test "PGN string" do
    assert ChessEngine.board_from_pgn("/////") == %ChessEngine.Board{}

    assert ChessEngine.board_from_pgn("r") == %ChessEngine.Board{
             board: %ChessEngine.Board{}.board |> List.replace_at(0, "r")
           }

    assert ChessEngine.board_from_pgn("/r") == %ChessEngine.Board{
             board: %ChessEngine.Board{}.board |> List.replace_at(0, "r")
           }
  end

  test "Pawn move validation" do
    m = 48

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "P")
           }) == [40, 32]

    m = 32

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "P")
           }) == [m - 8]
  end

  test "Rook move validation" do
    m = 0

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "R")
           }) == [1, 2, 3, 4, 5, 6, 7, 8, 16, 24, 32, 40, 48, 56]

    m = 7

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "R")
           }) == [0, 1, 2, 3, 4, 5, 6, 15, 23, 31, 39, 47, 55, 63]

    m = 56

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "R")
           }) == [48, 40, 32, 24, 16, 8, 0, 57, 58, 59, 60, 61, 62, 63]
  end

  test "Bishop move validation" do
    m = 0

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "B")
           }) == 9..63//9 |> Enum.to_list()

    m = 7

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "B")
           }) == 14..56//7 |> Enum.to_list()

    m = 56

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "B")
           }) == 49..7//-7 |> Enum.to_list()

    m = 34

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "B")
           }) == [27, 20, 13, 6, 25, 16, 41, 48, 43, 52, 61]
  end

  test "Queen move validation" do
    m = 56

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "Q")
           }) == [48, 40, 32, 24, 16, 8, 0, 57, 58, 59, 60, 61, 62, 63, 49, 42, 35, 28, 21, 14, 7]

    m = 0

    assert ChessEngine.Validation.possible_moves(m, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(m, "Q")
           }) == [1, 2, 3, 4, 5, 6, 7, 8, 16, 24, 32, 40, 48, 56, 9, 18, 27, 36, 45, 54, 63]
  end

  test "King move validation" do
    assert ChessEngine.Validation.possible_moves(0, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(0, "K")
           }) == [1, 8, 9]

    assert ChessEngine.Validation.possible_moves(7, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(7, "K")
           }) == [6, 14, 15]

    assert ChessEngine.Validation.possible_moves(1, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(1, "K")
           }) == [0, 2, 8, 9, 10]

    assert ChessEngine.Validation.possible_moves(56, %ChessEngine.Board{
             board:
               ChessEngine.board_from_pgn("").board
               |> List.replace_at(56, "K")
           }) == [48, 49, 57]
  end
end
