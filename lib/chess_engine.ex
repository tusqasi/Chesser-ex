defmodule ChessEngine do
  @moduledoc """
  Documentation for `ChessEngine`.
  """

  @doc """
  Makes a board from a pgn_str

  / => End of a file
  number => Empty places
  notation => Piece 
  """
  def init_standard_board do
    board_from_pgn("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
  end

  def board_from_pgn("") do
    %ChessEngine.Board{}
  end

  def board_from_pgn(pgn_str)
      when pgn_str |> is_bitstring do
    first = pgn_str |> String.first()
    rest = String.slice(pgn_str, 1..-1)
    board_from_pgn(first, rest, %ChessEngine.Board{}, 0)
  end

  def board_from_pgn(first, "", board, n) do
    %ChessEngine.Board{
      board:
        List.replace_at(
          board.board,
          n,
          first
        )
    }
  end

  def board_from_pgn("/", rest, board, n) do
    board_from_pgn(
      rest |> String.first(),
      String.slice(rest, 1..-1),
      board,
      if rem(n, 8) != 0 do
        8 - rem(n, 8) + n
      else
        n
      end
    )
  end

  def board_from_pgn(first, rest, board, n) do
    case(first |> Integer.parse()) do
      {num, ""} ->
        board_from_pgn(rest |> String.first(), rest, board, n + num)

      :error ->
        board_from_pgn(
          rest |> String.first(),
          String.slice(rest, 1..-1),
          %ChessEngine.Board{board: List.replace_at(board.board, n, first)},
          n + 1
        )
    end
  end
end
