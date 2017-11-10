/*
Jogador escolhe a peça que vai jogar
e o sentido do movimento da mesma
*/
selectPiece(CurrBoard, NewBoard, PlayerNum):-
  %write('\33\[2J'),
  %ite(PlayerNum = 1, displayPlayer1Turn, displayPlayer2Turn),
  showBoard(CurrBoard),
  repeat,
  write('Choose your piece.'), nl,
  write('Row (Number)'), getInteger(Y), %write(Y), nl,
  write('Column (Letter)'), getLetter(L), nl,convertLetterToNum(L, X), %write(X), nl,
  findPiece(CurrBoard, X-Y, Player),
  %write('Player: '), write(Player), nl,
  %write('PlayerNum: '), write(PlayerNum), nl,
  ite(
	PlayerNum = 1,
	(/*write('vamos ver se da certo...'), nl,*/ member(Player, [1, 11])/*, write('deu certo!'), nl*/),
	member(Player, [2, 22])),
  !,
  %write('selecionou bem a peca'), nl,
  defineDirection(CurrBoard, NewBoard, X-Y, Player).

defineDirection(CurrBoard, NewBoard, X-Y, Player):-
  member(Player, [1, 2]), !,
  repeat,
  write('Move the piece.'), nl,
  write('Row (Number)'), getInteger(Y1),
  write('Column (Letter)'), getLetter(L),
  convertLetterToNum(L, X1),
  convertToDirection(CurrBoard, Player, X-Y, X1-Y1, D),

  ite(
  	Player = 1,
  	validMan1Move(CurrBoard, X-Y, NewX-NewY, D),
  	validMan2Move(CurrBoard, X-Y, NewX-NewY, D)),
  updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player).

defineDirection(CurrBoard, FinalBoard, X-Y, Player):-
  member(Player, [11, 22]), !,
  repeat,
  write('Define direction'),
  getInteger(D),
  member(D, [1, 2, 3, 4, 6, 7, 8, 9]),
  %write('Define Directio: '),write(D),nl,
  keepMovingKing(CurrBoard, FinalBoard, X-Y, Player, D).

keepMovingKing(CurrBoard, FinalBoard, X-Y, Player, D):-
  validKingMove(CurrBoard, X-Y, NewX-NewY, Player, D),
  %write('Movimento Valido: '), write(D),nl,
	updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
  write('\33\[2J'),
  ite(Player = 11, displayPlayer1Turn, displayPlayer2Turn),
  showBoard(NewBoard),
  %write(NewX-NewY),nl,
  ite(validKingMove(NewBoard, NewX-NewY, X1-Y1, Player, D),
   (ite(
	    keepMoving(D),
	    keepMovingKing(NewBoard, FinalBoard, NewX-NewY, Player, D),
	    FinalBoard = NewBoard)), 
	  FinalBoard = NewBoard).

/*
O rei pode andar mais do que uma
casa na mesma linha de percurso
*/
keepMoving(Direction):-
  getInteger(D),
  ite(D = Direction,
    true,
    ite(member(D, [1, 2, 3, 4, 6, 7, 8, 9]), keepMoving(Direction), fail)).


/*
Movimento de captura
*/

selectCapturePiece(CurrBoard, Player, Moves, MaxCaptureNum, NewBoard) :-
  write('\33\[2J'),
  ite(Player = 1, displayPlayer1Turn, displayPlayer2Turn),
  showBoard(CurrBoard),
  ite(Player = 1, King is 11, King is 22),
  repeat,
  nl, write('Choose your piece.'), nl, nl,
  write('Row (Number)'), getInteger(Y),
  write('Column (Letter)'), getLetter(L), convertLetterToNum(L, X),
  findPiece(CurrBoard, X-Y, P),
  member(P, [Player, King]),
  removeCaptures(X-Y, 1, Moves, UpdatedMoves),
  \+length(UpdatedMoves, 0), !,
  nl, write('>>>>>>>>>>>>MOVE PIECE<<<<<<<<<<<<<<<'), nl, nl, nl,
  moveCapturePiece(CurrBoard, X-Y, P, UpdatedMoves, MaxCaptureNum, 2, NewBoard).


moveCapturePiece(CurrBoard,  X-Y, Player, Moves, MaxCaptureNum, CurrNum, NewBoard) :-
  ite(CurrNum > (MaxCaptureNum + 1),
    (
      write('No more pieces to capture'), nl,
      NewBoard = CurrBoard
    ),
    (
      write('\33\[2J'),
      ite(Player = 1, displayPlayer1Turn, displayPlayer2Turn),
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
