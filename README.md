# ChessEngine

## TODO
- [x] Make a board from PGN
- [ ] Check valid moves for a given piece
    - [x] Rook
    - [ ] Pawn
    - [x] Bishop
    - [ ] Knight
    - [ ] King
    - [ ] Queen


## How will the Engine work?

input -> sys -> out

sys == neural net

input => int[64], bool ?is_white

out   => next_move

# Running 
```bash
mix test
mix run -e "IO.inspect ChessEngine.init_standard_board"
mix run -e "IO.inspect ChessEngine.board_from_pgn(\"ppprprpPRPRP\")"                                                     1.15.5-otp-24
```
