game1Vs1(Board):-
  displayPlayer1Turn,
  selectPiece(Board, NewBoard1, 1),
  \+gameOver(NewBoard1, 2) -> (
  displayPlayer2Turn,
  selectPiece(NewBoard1, NewBoard2, 2),
  \+gameOver(NewBoard2, 1),
  game1Vs1(NewBoard2)
  ).
