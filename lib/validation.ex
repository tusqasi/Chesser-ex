defmodule ChessEngine.Validation do
  @doc """
  Returns a list of positions where the piece at the given index can move
  """
  def possible_moves(idx, board)
      when is_integer(idx) and
             is_struct(board, ChessEngine.Board) do
    piece = Enum.at(board.board, idx)
    possible_moves(idx, piece, board)
  end

  def possible_moves(idx, "K", _board) do
    # rank = div(idx, 8)
    file = rem(idx, 8)

    ([] ++
       if idx - 9 >= 0 and file != 0 do
         [idx - 9]
       else
         []
       end ++
       if idx - 8 >= 0 do
         [idx - 8]
       else
         []
       end ++
       if idx - 7 >= 0 and file != 7 do
         [idx - 7]
       else
         []
       end ++
       if idx - 1 >= 0 and file != 0 do
         [idx - 1]
       else
         []
       end ++
       if idx + 1 <= 63 and file != 7 do
         [idx + 1]
       else
         []
       end ++
       if idx + 7 <= 63 and file != 0 do
         [idx + 7]
       else
         []
       end ++
       if idx + 8 <= 63 do
         [idx + 8]
       else
         []
       end ++
       if idx + 9 <= 63 and file != 7 do
         [idx + 9]
       else
         []
       end)
    |> Enum.to_list()
  end

  def possible_moves(idx, "Q", board) do
    rook_n([], idx, board) ++
      rook_w(idx, board) ++
      rook_e(idx, board) ++
      rook_s([], idx, board) ++
      bishop_ne([], div(idx, 8) - 1, rem(idx, 8) + 1, board) ++
      bishop_se([], div(idx, 8) + 1, rem(idx, 8) + 1, board) ++
      bishop_sw([], div(idx, 8) + 1, rem(idx, 8) - 1, board) ++
      bishop_nw([], div(idx, 8) - 1, rem(idx, 8) - 1, board)
  end

  def possible_moves(idx, "N", board) do
    knight(idx, board)
  end

  def possible_moves(idx, "B", board) do
    bishop_ne([], div(idx, 8) - 1, rem(idx, 8) + 1, board) ++
      bishop_nw([], div(idx, 8) - 1, rem(idx, 8) - 1, board) ++
      bishop_sw([], div(idx, 8) + 1, rem(idx, 8) - 1, board) ++
      bishop_se([], div(idx, 8) + 1, rem(idx, 8) + 1, board)
  end

  def possible_moves(idx, "P", _board) do
    if(div(idx, 8) == 6) do
      [idx - 8, idx - 8 * 2]
    else
      [idx - 8]
    end
  end

  def possible_moves(idx, "R", board) do
    rook_n([], idx, board) ++
      rook_w(idx, board) ++
      rook_e(idx, board) ++
      rook_s([], idx, board)
  end

  def knight(idx, _board) do
    moves = []

    moves =
      if(idx - 17 > 0) do
        moves ++ []
      else
        moves
      end

    moves =
      if(idx - 15 > 0) do
        moves ++ []
      else
        moves
      end

    moves =
      if(idx - 6 > 0) do
        moves ++ []
      else
        moves
      end

    moves =
      if(idx - 10 > 0) do
        moves ++ []
      else
        moves
      end

    moves =
      if(idx + 10 < 63) do
        moves ++ []
      else
        moves
      end

    moves =
      if(idx + 10 < 63) do
        moves ++ []
      else
        moves
      end

    moves =
      if(idx + 15 < 63) do
        moves ++ []
      else
        moves
      end

    if(idx + 17 < 63) do
      moves ++ []
    else
      moves
    end
  end

  def bishop_sw(possible_moves, rank, file, _board)
      when rank > 7 or file > 7 or rank < 0 or file < 0 do
    possible_moves
  end

  def bishop_sw(possible_moves, rank, file, _board)
      when rank == 0 or
             file == 0 or
             rank == 7 or
             file == 7 do
    possible_moves ++ [rank * 8 + file]
  end

  def bishop_sw(possible_moves, rank, file, board) do
    bishop_sw(possible_moves ++ [rank * 8 + file], rank + 1, file - 1, board)
  end

  def bishop_se(possible_moves, rank, file, _board)
      when rank > 7 or file > 7 or rank < 0 or file < 0 do
    possible_moves
  end

  def bishop_se(possible_moves, rank, file, _board)
      when rank == 0 or
             file == 0 or
             rank == 7 or
             file == 7 do
    possible_moves ++ [rank * 8 + file]
  end

  def bishop_se(possible_moves, rank, file, board) do
    bishop_se(possible_moves ++ [rank * 8 + file], rank + 1, file + 1, board)
  end

  def bishop_nw(possible_moves, rank, file, _board)
      when rank > 7 or file > 7 or rank < 0 or file < 0 do
    possible_moves
  end

  def bishop_nw(possible_moves, rank, file, _board)
      when rank == 0 or
             file == 0 or
             rank == 7 or
             file == 7 do
    possible_moves ++ [rank * 8 + file]
  end

  def bishop_nw(possible_moves, rank, file, board) do
    bishop_nw(possible_moves ++ [rank * 8 + file], rank - 1, file - 1, board)
  end

  def bishop_ne(possible_moves, rank, file, _board)
      when rank > 7 or file > 7 or rank < 0 or file < 0 do
    possible_moves
  end

  def bishop_ne(possible_moves, rank, file, _board)
      when rank == 0 or
             file == 0 or
             rank == 7 or
             file == 7 do
    possible_moves ++ [rank * 8 + file]
  end

  def bishop_ne(possible_moves, rank, file, board) do
    bishop_ne(possible_moves ++ [rank * 8 + file], rank - 1, file + 1, board)
  end

  def rook_w(idx, _board) do
    rank = div(idx, 8)

    if(rank * 8 == idx) do
      []
    else
      (rank * 8)..if rank * 8 == idx do
        idx
      else
        idx - 1
      end
      |> Enum.to_list()
    end
  end

  def rook_e(idx, _board) do
    rank = div(idx, 8)

    if((rank + 1) * 8 - 1 == idx) do
      []
    else
      if (rank + 1) * 8 - 1 == idx do
        idx
      else
        idx + 1
      end..((rank + 1) * 8 - 1)
      |> Enum.to_list()
    end
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
end
