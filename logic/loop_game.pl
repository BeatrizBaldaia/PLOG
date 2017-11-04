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

mandatoryCapture(Board, NewBoard, Player):-
	setof(Num-X-Y-Move,captureNumber(Board,X-Y,Num,Player,Move),_L), 
	reverse(_L,[Num-X-Y-Move|Rest]),
	ite(Num = 0,
		selectPiece(Board, NewBoard, Player),
		(getPossivelCaptures([Num-X-Y-Move|Rest], Moves, Num),		
		selectPieceCapture(Board, NewBoard, Player, Moves, Num)
		)).

gamePCvsPC(InitialBoard):-
  assert(keep(InitialBoard, 1)),
	repeat,
		retract(keep(Board, Player)),
		once(playGamePC(Player, Board, NewPlayer, NewBoard1)),
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
  applyMovePC(Board, NewBoard, Move, 1,Simple).
playGamePC(2, Board, 1, NewBoard):-  
  displayPlayer2Turn,
	showBoard(Board),
  validMovesPC(Board, 2, Moves, Simple),
  chooseMovePC(Moves, Move),
  applyMovePC(Board, NewBoard, Move, 2,Simple).
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
	random_member(Move, Moves).%Nivel 1

applyMovePC(CurrBoard, NewBoard, [X-Y,NewX-NewY], Player, yes):-
write('Simple Move'), nl,	
updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player).
applyMovePC(CurrBoard, NewBoard, [X-Y],Player,no).
applyMovePC(CurrBoard, NewBoard, [X-Y,NewX-NewY|Rest],Player, no):- nl,
	write('Viva la vida'), nl,
	updateBoardSimpleMove(CurrBoard, _updateBoard, X-Y, NewX-NewY, Player),
	takeAdversary(X-Y, NewX-NewY, _updateBoard, _updateBoard1),
	applyMovePC(_updateBoard1,  NewBoard, [NewX-NewY|Rest],Player, no).

takeAdversary(X-Y, NewX-NewY, CurrBoard, NewBoard):-
	ite(X = NewX,
		(ite(NewY > Y, Y1 is NewY-1, Y1 is NewY+1),
		putPiece(CurrBoard, NewBoard, X-Y1, 0)
		),
		(ite(NewX > X, X1 is NewX-1, X1 is NewX+1),
		putPiece(CurrBoard, NewBoard, X1-Y, 0)
		)).
	







