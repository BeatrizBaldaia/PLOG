/*game1Vs1(Board):-
  displayPlayer1Turn,
  selectPiece(Board, NewBoard1, 1),
  \+gameOver(NewBoard1, 2) -> (
  displayPlayer2Turn,
  selectPiece(NewBoard1, NewBoard2, 2),
  \+gameOver(NewBoard2, 1),
  game1Vs1(NewBoard2)
  ).*/

game1Vs1(InitialBoard):-
  assert(keep(InitialBoard, 1)),
	repeat,
		retract(keep(Board, Player)),
		once(playGame(Player, Board, NewPlayer, NewBoard1)),
		once(promotedToKing(NewBoard1, NewBoard)),
		assert(keep(NewBoard, NewPlayer)),
		gameOver(NewBoard, NewPlayer).

playGame(1, Board, 2, NewBoard):-
  displayPlayer1Turn,
  selectPiece(Board, NewBoard, 1).
playGame(2, Board, 1, NewBoard):-
  displayPlayer2Turn,
  selectPiece(Board, NewBoard, 2).

