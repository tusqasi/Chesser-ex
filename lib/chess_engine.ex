defmodule ChessEngine do
  @moduledoc """
  Documentation for `ChessEngine`.
  """

  @doc """
  Makes a standard chess game starting position

    iex> ChessEngine.init_standard_board()
  """
  def init_standard_board do
    board_from_pgn("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
  end

  @doc """
  Makes a board from a pgn_str
  <table>
  <tr>
    <td>
     <code> / </code>
    </td>
    <td> End of a file </td>
  </tr>
  <tr>
    <td>
     <code> Integer </code>
    </td>
    <td> Empty places </td>
  </tr>

  <tr>
    <td> Notation <code> [p,  r, k, n, q, b, P, R, K, N, Q, B] </code>
    </td>
    <td> Piece </td>
  </tr>
  </table>

  ## Examples
    ```
    iex> ChessEngine.board_from_pgn("")
    %ChessEngine.Board{ board: [
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, 
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, 
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty, 
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,
      :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty
    ]}
    ```
  """
  def board_from_pgn(pgn_str)
      when pgn_str != "" and is_bitstring(pgn_str) do
    first = String.first(pgn_str)
    rest = String.slice(pgn_str, 1..-1)
    board_from_pgn(first, rest, %ChessEngine.Board{}, 0)
  end

  def board_from_pgn("") do
    %ChessEngine.Board{}
  end

  defp board_from_pgn("/", "", board, _n) do
    board
  end

  defp board_from_pgn(_, _, board, n) when n > 63 do
    board
  end

  defp board_from_pgn("/", rest, board, n) do
    board_from_pgn(
      String.first(rest),
      String.slice(rest, 1..-1),
      board,
      if rem(n, 8) == 0 do
        n
      else
        8 - rem(n, 8) + n + 8
      end
    )
  end

  defp board_from_pgn(first, "", board, n) do
    %ChessEngine.Board{
      board:
        List.replace_at(
          board.board,
          n,
          first
        )
    }
  end

  defp board_from_pgn(first, rest, board, n) do
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
