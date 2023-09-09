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
    "%ChessEngine.Board{ board: [\n" <>
      (board
       |> Enum.map(fn
         :empty -> ":empty,"
         x -> x <> ",     "
       end)
       |> Enum.chunk_every(8)
       |> Enum.map(fn x -> "\t" <> List.to_string(x) end)
       |> Enum.join("\n")) <>
      "\n]}"
  end
end
