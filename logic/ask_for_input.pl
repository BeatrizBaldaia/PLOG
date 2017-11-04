/*
Jogador escolhe a peça que vai jogar
e o sentido do movimento da mesma
*/
selectPiece(CurrBoard, NewBoard, PlayerNum):-
  showBoard(CurrBoard),
repeat,
  write('Choose your piece.'), nl,
  write('Row (Number)'), read(Y),
  write('Column (Letter)'), read(L),convertLetterToNum(L, X),
  findPiece(CurrBoard, X-Y, Player),
  ite(
	PlayerNum = 1,
	member(Player, [1, 11]),
	member(Player, [2, 22])),
  !,
  defineDirection(CurrBoard, NewBoard, X-Y, Player).

defineDirection(CurrBoard, NewBoard, X-Y, Player):-
  member(Player, [1, 2]), !,
  repeat,
  write('Move the piece.'), nl,
  read(D),
ite(
	Player = 1,
	(write('Move player 1'), nl,
		write(X),write('-'),write(Y),nl,write(D),nl,
		validMan1Move(CurrBoard, X-Y, NewX-NewY, 1, D),
		write('ERRO')),
	(write('Move player 2'), nl,
		validMan2Move(CurrBoard, X-Y, NewX-NewY, 2, D))),
  updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
  showBoard(NewBoard).

defineDirection(CurrBoard, FinalBoard, X-Y, Player):-
  member(Player, [11, 22]), !,
  repeat,
  write('Move the piece.'), nl,
  read(D),
  member(D, [1, 2, 3, 4, 6, 7, 8, 9]),
  write('Hate My'),
  keepMovingKing(CurrBoard, FinalBoard, X-Y, Player, D).

keepMovingKing(CurrBoard, FinalBoard, X-Y, Player, D):-
  ite(
	Player = 11,
	(write('Move player 1'), nl, validKing1Move(CurrBoard, X-Y, NewX-NewY, Player, D)),
	(write('Move player 2'), nl, validKing2Move(CurrBoard, X-Y, NewX-NewY, Player, D))),
  updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
  showBoard(NewBoard),
  ite(
	keepMoving(D),
	keepMovingKing(NewBoard, FinalBoard, NewX-NewY, Player, D),
	FinalBoard = NewBoard).

/*
O rei pode andar mais do que uma
casa na mesma linha de percurso
*/
keepMoving(Direction):-
  read(D),
  D = Direction ->  true;%para continuar a mover no ciclo repeat
  D \= '\n' -> keepMoving(Direction);%introduziu a direcao errada
  fail.


/*
Listar as capturas obrigatorias possiveis
paea o jogador escolher
*/

selectCapturePiece(CurrBoard, Player, Moves, MaxCaptureNum, NewBoard) :-
  showBoard(CurrBoard),
  repeat,
  nl, write('Choose your piece.'), nl,
  write('Row (Number)'), read(Y),
  write('Column (Letter)'), read(L), convertLetterToNum(L, X),
  findPiece(CurrBoard, X-Y, Player),
  isCapturePiece(X-Y, Moves),
  removeCaptures(X-Y, 1, Moves, UpdatedMoves),
  \+length(UpdatedMoves, 0), !,
  nl, write('Move piece'), nl,
  moveCapturePiece(CurrBoard, X-Y, Player, UpdatedMoves, MaxCaptureNum, 2, NewBoard).


moveCapturePiece(CurrBoard, X-Y, Player, Moves, MaxCaptureNum, MaxCaptureNum, NewBoard) :-
  write('No more pieces to capture'), nl,
  NewBoard = CurrBoard.

moveCapturePiece(CurrBoard,  X-Y, Player, Moves, MaxCaptureNum, CurrNum, NewBoard) :-
  write('Row (Number)'), read(Y1),
  write('Column (Letter)'), read(L), convertLetterToNum(L, X1),
  findPiece(CurrBoard, X1-Y1, 0),
  removeCaptures(X1-Y1, 1, Moves, UpdatedMoves),
  ite(length(UpdatedMoves, 0),
    moveCapturePiece(CurrBoard,  X-Y, Player, Moves, MaxCaptureNum, CurrNum, NewBoard),
    (updateBoardCaptureMove(CurrBoard, UpdatedBoard, X-Y, X1-Y1, Player), NewNum is CurrNum + 1, moveCapturePiece(UpdatedBoard, X1-Y1, Player, MaxCaptureNum, NewNum, NewBoard))).
