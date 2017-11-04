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
		/*once(promotedToKing(NewBoard1, NewBoard)),
		assert(gameState(NewBoard, NewPlayer)),*/
    assert(gameState(NewBoard1, NewPlayer)),
		gameOver(NewBoard, NewPlayer).

playGame(Player, CurrBoard, NewPlayer, NewBoard):-
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
  assert(keep(InitialBoard, 1)),
	repeat,
		retract(keep(Board, Player)),
		once(playGamePC(Player, Board, NewPlayer, NewBoard1)),
		write('PC'),
		write(NewBoard1),
		once(promotedToKing(NewBoard1, NewBoard)),
		write('King'),
		assert(keep(NewBoard, NewPlayer)),
		write('assertr'),
		gameOver(NewBoard, NewPlayer).

playGamePC(1, Board, 2, NewBoard):-
  displayPlayer1Turn,
	showBoard(Board),
  validMovesPC(Board, 1, Moves, Simple),
  chooseMovePC(Moves, Move),
	write(Board), write(Move),nl,
  applyMovePC(Board, NewBoard, Move, Simple),
	nl,write(NewBoard),nl,nl.
playGamePC(2, Board, 1, NewBoard):-
  displayPlayer2Turn,
	showBoard(Board),
  validMovesPC(Board, 2, Moves, Simple),
  chooseMovePC(Moves, Move),
	write(Board), write(Move),nl,
  applyMovePC(Board, NewBoard, Move, Simple),
	write(NewBoard),nl,nl.
%DOUBLE
validMovesPC(Board, Player, Moves, no):-
	mandatoryCapturePC(Board, Player, Moves).
validMovesPC(Board, Player, Moves, yes):-
	findall(Move,validMovePC(Board, Player, Move),Moves).
validMovePC(Board, Player, [X-Y,NewX-NewY]):-
	ite(Player = 1,
	validMan1Move(Board, X-Y, NewX-NewY, Player, D),
	validMan2Move(Board, X-Y, NewX-NewY, Player, D)).


mandatoryCapturePC(Board, NewBoard, Moves):-
	setof(Num-X-Y-Move,captureNumber(Board,X-Y,Num,Player,Move),_L),
	reverse(_L,[Num-X-Y-Move|Rest]),
	ite(Num = 0, fail,
	getPossivelCaptures([Num-X-Y-Move|Rest], Moves, Num)).


chooseMovePC(Moves, Move):-
	random_member(Move, Moves),
	write('Rand').%Nivel 1

applyMovePC(CurrBoard, NewBoard, [X-Y|NewX-NewY], yes):-
	updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player).
applyMovePC(CurrBoard, NewBoard, [X-Y], no).
applyMovePC(CurrBoard, NewBoard, [X-Y,NewX-NewY|Rest], no):-
	updateBoardSimpleMove(CurrBoard, _updateBoard, X-Y, NewX-NewY, Player),
	takeAdversary(X-Y, NewX-NewY, _updateBoard, _updateBoard1),
	applyMovePC(_updateBoard1,  NewBoard, [NewX-NewY|Rest], no).
takeAdversary(X-Y, NewX-NewY, CurrBoard, NewBoard):-
	ite(X = NewX,
		(itf(NewY > Y, Y1 is NewY-1, Y1 is NewY+1),
		putPiece(CurrBoard, NewBoard, X-Y1, 0)
		),
		(itf(NewX > X, X1 is NewX-1, X1 is NewX+1),
		putPiece(CurrBoard, NewBoard, X1-Y, 0)
		)).
