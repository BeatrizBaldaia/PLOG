/*
Jogador escolhe a peça que vai jogar
e o sentido do movimento da mesma
*/
selectPiece(CurrBoard, NewBoard, PlayerNum):-
  showBoard(CurrBoard),
repeat,
  write('Choose your piece.'), nl,
  write('Row (Number)'), read(Y),
  write('Column (Letter)'), read(L), convertLetterToNum(L, X),
  findPiece(CurrBoard, X-Y, Player), !,%TESTE
  PlayerNum = 1 -> (member(Player, [1, 11]), !, defineDirection(CurrBoard, NewBoard, X-Y, PlayerNum, Player));
  member(Player, [2, 22]), !, write('NEW'),defineDirection(CurrBoard, NewBoard, X-Y, PlayerNum, Player).

defineDirection(CurrBoard, NewBoard, X-Y, PlayerNum, Player):-
  write('Move the piece.'), nl,
  read(D),
%  repeat,
  Player = 1 ->
     (write('Move player 1'),nl,validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
     showBoard(NewBoard));
 % Player = 2 ->
      (write('Move player 2'),nl,validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
      showBoard(NewBoard)).%, CurrBoard is NewBoard;
/*  repeat,
  read(D),
  member(D, [1, 2, 3, 4, 6, 7, 8, 9]), !,
  repeat,
  Player = 11 ->
    validKing1Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
    showBoard(NewBoard), CurrBoard is NewBoard, keepMoving(NewX-NewY, Player, Direction);
  Player = 22 ->
    validKing2Move(CurrBoard, X-Y, NewX-NewY, Player, D), updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
    showBoard(NewBoard), CurrBoard is NewBoard, keepMoving(NewX-NewY, Player, Direction).
*/
/*
O rei pode andar mais do que uma
casa na mesma linha de percurso
*/
keepMoving(X-Y, Player, Direction):-
  read(D),
  D = Direction ->  fail;%para continuar a mover no ciclo repeat
  D \= '\n' -> keepMoving(X-Y, Player, Direction).%introduziu a direcao errada
