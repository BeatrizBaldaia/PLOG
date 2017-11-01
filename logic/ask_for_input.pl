/*
Jogador escolhe a peça que vai jogar
e o sentido do movimento da mesma
*/
defineDirection(PlayerNum):-
  repeat,
  write('Choose your piece.'), nl,
  read(X-Y),
  findPiece(CurrBoard, X-Y, Player),
  PlayerNum = 1 -> member(Player, [1, 11]);
  member(Player, [2, 22]), !,
  write('Move the piece.'), nl,
  repeat,
  Player = 1 ->
      validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
      showBoard(NewBoard);
  Player = 2 ->
      validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
      showBoard(NewBoard);
  repeat,
  read(D),
  member(D, [1, 2, 3, 4, 6, 7, 8, 9]), !,
  repeat,
  Player = 11 ->
    validKing1Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
    showBoard(NewBoard), keepMoving(NewX-NewY, Player, Direction);
  Player = 22 ->
    validKing2Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
    showBoard(NewBoard), keepMoving(NewX-NewY, Player, Direction).

/*
O rei pode andar mais do que uma
casa na mesma linha de percurso
*/
keepMoving(X-Y, Player, Direction):-
  read(D),
  D = Direction ->  fail;%para continuar a mover no ciclo repeat
  D \= '\n' -> keepMoving(X-Y, Player, Direction).%introduziu a direcao errada
