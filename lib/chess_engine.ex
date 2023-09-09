defmodule ChessEngine do
  @moduledoc """
  Documentation for `ChessEngine`.
  """

  @doc """
  Returns a list of positions where the given piece can move
  """
  def valid_moves(idx, board)
      when is_integer(idx) and
             is_struct(board, ChessEngine.Board) do
    piece = Enum.at(board.board, idx)
    valid_moves(idx, piece, board)
  end

  def valid_moves(idx, "r", board) do
    rook_n([], idx, board) ++
      rook_w(idx, board) ++
      rook_e(idx, board) ++
      rook_s([], idx, board)
  end

  def rook_w(idx, _board) do
    rank = div(idx, 8)
    # file = rem(idx, 8)

    (rank * 8)..(idx - 1)
    |> Enum.to_list()
  end

  def rook_e(idx, _board) do
    rank = div(idx, 8)

    (idx + 1)..((rank + 1) * 8 - 1)
    |> Enum.to_list()
  end

  def rook_s(possible_moves, idx, _board) when idx > 55 do
    possible_moves
  end

  def rook_s(possible_moves, idx, board) do
    check_piece = Enum.at(board.board, idx + 8)

    cond do
      check_piece == :empty ->
        rook_s(possible_moves ++ [idx + 8], idx + 8, board)

      check_piece in ["R", "K", "P", "N", "Q", "B"] ->
        rook_s(possible_moves, idx + 8, board)

      true ->
        possible_moves ++ [idx]
    end
  end

  def rook_n(possible_moves, idx, _board) when idx < 8 do
    possible_moves
  end

  def rook_n(possible_moves, idx, board) do
    check_piece = Enum.at(board.board, idx - 8)

    cond do
      check_piece == :empty ->
        rook_n(possible_moves ++ [idx - 8], idx - 8, board)

      check_piece in ["R", "K", "P", "N", "Q", "B"] ->
        rook_n(possible_moves, idx - 8, board)

      true ->
        possible_moves ++ [idx]
    end
  end

  @doc """
  Makes a standard chess game starting position

    iex> ChessEngine.init_standard_board()
  """
  def init_standard_board do
    board_from_pgn("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
  end

  @doc """
  Makes a board from a pgn_str

  / => End of a file
  number => Empty places
  notation => Piece 

  ## Examples

    iex> ChessEngine.board_from_pgn("")
    %ChessEngine.Board{ board: [ :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty ]}

  """
  def board_from_pgn("") do
    %ChessEngine.Board{}
  end

  def board_from_pgn(pgn_str)
      when is_bitstring(pgn_str) do
    first = String.first(pgn_str)
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
      String.first(rest),
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
    case(Integer.parse(first)) do
      {num, ""} ->
        board_from_pgn(String.first(rest), rest, board, n + num)

      :error ->
        board_from_pgn(
          String.first(rest),
          String.slice(rest, 1..-1),
          %ChessEngine.Board{board: List.replace_at(board.board, n, first)},
          n + 1
        )
    end
  end
end
