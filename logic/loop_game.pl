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
  assert(keep(InitialBoard, 1)),
	repeat,
		retract(keep(Board, Player)),
		once(playGamePC(Player, Board, NewPlayer, NewBoard1)),
		once(promotedToKing(NewBoard1, NewBoard)),
		assert(keep(NewBoard, NewPlayer)),
		gameOver(NewBoard, NewPlayer).

playGamePC(Player, Board, NewPlayer, NewBoard):-
  write('\33\[2J'),
  ite(Player = 1,(displayPlayer1Turn, NewPlayer = 2),(displayPlayer2Turn, NewPlayer = 1)),
  showBoard(Board),
  validMovesPC(Board, Player, Moves, Simple),
  chooseMovePC(Moves, Move),
  applyMovePC(Board, NewBoard, Move, Player,Simple).

validMovesPC(Board, Player, Moves, no):-
	mandatoryCapturePC(Board, Player, Moves).
validMovesPC(Board, Player, Moves, yes):-
	findall(Move,validMovePC(Board, Player, Move),Moves).
validMovePC(Board, Player, [X-Y,NewX-NewY]):-
	ite(Player = 1,
	validMan1Move(Board, X-Y, NewX-NewY, D),
	validMan2Move(Board, X-Y, NewX-NewY, D)).
validMovePC(Board, Player, [X-Y,NewX-NewY]):-
	write('Trying to find valid King Move'),nl,
	ite(Player = 1,
	validKingMove(Board, X-Y, NewX-NewY, 11, D),
	validKingMove(Board, X-Y, NewX-NewY, 22, D)).

mandatoryCapturePC(Board, Player, Moves):-
	setof(Num-X-Y-Move,captureNumber(Board, X-Y, Num, Player, Move),_L),
	reverse(_L,[Num-X-Y-Move|Rest]),
	write('Num Capt'),write(Num),nl,
	ite(Num = 0, fail,
	getPossivelCaptures([Num-X-Y-Move|Rest], Moves, Num)).

chooseMovePC(Moves, Move):-
	random_member(Move, Moves).%Nivel 1

applyMovePC(CurrBoard, NewBoard, [X-Y,NewX-NewY], Player, yes):-
  updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player).

applyMovePC(NewBoard, NewBoard, [X-Y],Player,no).

applyMovePC(CurrBoard, NewBoard, [X-Y,NewX-NewY|Rest],Player, no):-
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
