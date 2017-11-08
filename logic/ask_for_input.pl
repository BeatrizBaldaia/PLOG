/*
Jogador escolhe a peça que vai jogar
e o sentido do movimento da mesma
*/
selectPiece(CurrBoard, NewBoard, PlayerNum):-
  showBoard(CurrBoard),
  repeat,
  write('Choose your piece.'), nl,
  write('Row (Number)'), getInteger(Y),
  write('Column (Letter)'), getLetter(L), write('L = '), write(L), nl,convertLetterToNum(L, X),
  write('depois do convertLetterToNum'), nl,
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
  write('Row (Number)'), getInteger(Y1),
  write('Column (Letter)'), getLetter(L),
  write('L = '), write(L), nl,
  convertLetterToNum(L, X1),
  write('Convertida para numero'), nl, write(X1), nl, nl,
  convertToDirection(CurrBoard, Player, X-Y, X1-Y1, D),
  write('Direction = '), write(D), nl,nl,

  ite(
  	Player = 1,
  	validMan1Move(CurrBoard, X-Y, NewX-NewY, D),
  	validMan2Move(CurrBoard, X-Y, NewX-NewY, D)),
  updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
  showBoard(NewBoard).

defineDirection(CurrBoard, FinalBoard, X-Y, Player):-
  member(Player, [11, 22]), !,
  repeat,
  write('Move the piece.'), nl, nl,
  read(D),
  member(D, [1, 2, 3, 4, 6, 7, 8, 9]),
  keepMovingKing(CurrBoard, FinalBoard, X-Y, Player, D).

keepMovingKing(CurrBoard, FinalBoard, X-Y, Player, D):-
  write('Move player '), write(Player), nl,
  validKingMove(CurrBoard, X-Y, NewX-NewY, Player, D),
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
  ite(D = Direction,
    true,
    ite(member(D, [1, 2, 3, 4, 6, 7, 8, 9]), keepMoving(Direction), fail)).


/*
Movimento de captura
*/

selectCapturePiece(CurrBoard, Player, Moves, MaxCaptureNum, NewBoard) :-
  showBoard(CurrBoard),
  ite(Player = 1, King is 11, King is 22),
  repeat,
  nl, write('Choose your piece.'), nl,
  write('Row (Number)'), read(Y),
  write('Column (Letter)'), read(L), convertLetterToNum(L, X),
  findPiece(CurrBoard, X-Y, P),
  member(P, [Player, King]),
  removeCaptures(X-Y, 1, Moves, UpdatedMoves),
  \+length(UpdatedMoves, 0), !,
  nl, write('>>>>>>>>>>>>>>>>>>>>>MOVE PIECE<<<<<<<<<<<<<<<<<<<<<'), nl, nl, nl,
  moveCapturePiece(CurrBoard, X-Y, P, UpdatedMoves, MaxCaptureNum, 2, NewBoard).


moveCapturePiece(CurrBoard,  X-Y, Player, Moves, MaxCaptureNum, CurrNum, NewBoard) :-
  write('CurrNum: '), write(CurrNum), nl,
  ite(CurrNum > (MaxCaptureNum + 1),
    (
      write('No more pieces to capture'), nl,
      NewBoard = CurrBoard
    ),
    (
      showBoard(CurrBoard),
      repeat,
      write('Row (Number)'), getInteger(Y1),
      write('Column (Letter)'), getLetter(L), convertLetterToNum(L, X1),
      findPiece(CurrBoard, X1-Y1, 0),
      removeCaptures(X1-Y1, CurrNum, Moves, UpdatedMoves),
      ite(length(UpdatedMoves, 0),
        %moveCapturePiece(CurrBoard,  X-Y, Player, Moves, MaxCaptureNum, CurrNum, NewBoard),
        fail,
        (
        updateBoardCaptureMove(CurrBoard, UpdatedBoard, X-Y, X1-Y1, Player),
        NewNum is CurrNum + 1,
        moveCapturePiece(UpdatedBoard, X1-Y1, Player, Moves, MaxCaptureNum, NewNum, NewBoard))
        )
     )
  ).
