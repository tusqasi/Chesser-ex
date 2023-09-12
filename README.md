# ChessEngine

## TODO
-[x] Make a board from PGN
-[x] Check possible moves for a given piece
    -[x] Rook
    -[x] Pawn
        - Pawn can move two place for its first move
        - How to know if it was moved or not?
    -[x] Bishop
    -[x] Knight
    -[x] King
        -[ ] Castling
    -[x] Queen
-[ ] Check legal moves
    -[ ] Rook
    -[ ] Pawn
        -[ ] Enpassant
        -[ ] First move
    -[ ] Bishop
    -[ ] Knight
    -[ ] King
        -[ ] Checks
    -[ ] Queen


## How will the Engine work?

input -> sys -> out

sys == neural net

input => int[64], bool ?is_white

out   => next_move

## Running, Testing
```bash
mix test
mix run -e "IO.inspect ChessEngine.init_standard_board"
mix run -e "IO.inspect ChessEngine.board_from_pgn(\"ppprprpPRPRP\")"
```
