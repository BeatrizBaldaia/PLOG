/*game1Vs1(Board):-
  displayPlayer1Turn,
  selectPiece(Board, NewBoard1, 1),
  \+gameOver(NewBoard1, 2) -> (
  displayPlayer2Turn,
  selectPiece(NewBoard1, NewBoard2, 2),
  \+gameOver(NewBoard2, 1),
  game1Vs1(NewBoard2)
  ).*/
:- dynamic gameState/2.

game1Vs1(InitialBoard):-
  assert(gameState(InitialBoard, 1)),
	repeat,
		retract(gameState(Board, Player)),
		once(playGame(Player, Board, NewPlayer, NewBoard1)),
		once(promotedToKing(NewBoard1, NewBoard)),
		assert(gameState(NewBoard, NewPlayer)),
  %  assert(gameState(NewBoard1, NewPlayer)),
		gameOver(NewBoard, NewPlayer).

playGame(Player, CurrBoard, NewPlayer, NewBoard):-
  write('\33\[2J'),
  ite(Player = 1, displayPlayer1Turn, displayPlayer2Turn),
  mandatoryCapture(CurrBoard, NewBoard, Player),
  ite(Player = 1, NewPlayer is 2, NewPlayer is 1).

mandatoryCapture(CurrBoard, NewBoard, Player):-
	setof(Num-X-Y-Move,captureNumber(CurrBoard,X-Y,Num,Player,Move),_L),
	reverse(_L,[Num-X-Y-Move|Rest]),
	ite(Num = 0,
		selectPiece(CurrBoard, NewBoard, Player),
		(getPossivelCaptures([Num-X-Y-Move|Rest], Moves, Num),
		selectCapturePiece(CurrBoard, Player, Moves, Num, NewBoard)
		)).

gamePCvsPC(InitialBoard):-
	retractall(keep(_A,_B)),
  assert(keep(InitialBoard, 1)),
	repeat,
		retract(keep(Board, Player)),
		once(playGamePC(Player, Board, NewPlayer, NewBoard1)),
		once(promotedToKing(NewBoard1, NewBoard)),
		assert(keep(NewBoard, NewPlayer)),
    sleep(3),
		gameOver(NewBoard, NewPlayer).

playGamePC(Player, Board, NewPlayer, NewBoard):-
  write('\33\[2J'),
  ite(Player = 1,(displayPlayer1Turn, NewPlayer = 2),(displayPlayer2Turn, NewPlayer = 1)),
  showBoard(Board),
  validMovesPC(Board, Player, Moves, Simple),
  chooseMovePC(Moves, Move),
  applyMovePC(Board, NewBoard, Move, Player,Simple).

