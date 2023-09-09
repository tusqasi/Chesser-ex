defmodule ChessEngine.Board do
  defstruct board: [
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
              :empty
            ]
end

defimpl Inspect, for: ChessEngine.Board do
  def inspect(%ChessEngine.Board{board: board}, _opts) do
    board
    |> Enum.map(fn
      :empty -> "0 "
      x -> x <> " "
    end)
    |> Enum.chunk_every(8)
    |> Enum.map(&List.to_string/1)
    |> Enum.join("\n")
  end
end
