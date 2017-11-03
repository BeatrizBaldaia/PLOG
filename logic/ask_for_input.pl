/*
Jogador escolhe a peça que vai jogar
e o sentido do movimento da mesma
*/
selectPiece(CurrBoard, NewBoard, 1):-
  showBoard(CurrBoard),
repeat,
  write('Choose your piece.'), nl,
  write('Row (Number)'), read(Y),
  write('Column (Letter)'), read(L),convertLetterToNum(L, X),
  findPiece(CurrBoard, X-Y, Player),
  !,
  member(Player, [1, 11]), !, defineDirection(CurrBoard, NewBoard, X-Y, Player).

selectPiece(CurrBoard, NewBoard, 2):-
  showBoard(CurrBoard),
repeat,
  write('Choose your piece.'), nl,
  write('Row (Number)'), read(Y),
  write('Column (Letter)'), read(L), convertLetterToNum(L, X),
  findPiece(CurrBoard, X-Y, Player),
  !,
  member(Player, [2, 22]), !, defineDirection(CurrBoard, NewBoard, X-Y, Player).

defineDirection(CurrBoard, NewBoard, X-Y, Player):-
  member(Player, [1, 2]), !,
  write('Move the piece.'), nl,
  read(D),
ite(
	Player = 1,
	(write('Move player 1'),nl,
		validMan1Move(CurrBoard, X-Y, NewX-NewY, 1, D)),
	(write('Move player 2'),nl,
		validMan2Move(CurrBoard, X-Y, NewX-NewY, 2, D))),
  updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
  showBoard(NewBoard).

defineDirection(CurrBoard, FinalBoard, X-Y, Player):-
  write('Move the piece.'), nl,
  read(D),
  member(D, [1, 2, 3, 4, 6, 7, 8, 9]), !,
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

