/*
Predicado para encontrar pecas
*/
findPiece(Board, X-Y, Piece):-
    nth1(Y, Board, Row),
    nth1(X, Row, Piece).

/*
Predicado para obter a direcao de um movimento simples
*/
convertToDirection(X-Y, X1-Y1, D):-
  Xaux1 is X - X1,
  abs(Xaux1, Xaux),
  Xaux @=< 1,
  Yaux1 is Y - Y1,
  abs(Yaux1, Yaux),
  Yaux @=< 1,
  (Xaux =< 1, Yaux =< 1) -> (
  ite((X = X1, Y = Y1), D is 0, true),

  Y = Y1 -> (%movimento horizontal
    X > X1 -> D is 4;
    X < X1 -> D is 6
  );
  X = X1 -> (%movimento vertical
    Y > Y1 -> D is 8;
    Y < Y1 -> D is 2
  );
  (X1 > X, Y1 > Y) -> D is 3;
  (X1 > X, Y1 < Y) -> D is 9;
  (X1 < X, Y1 > Y) -> D is 1;
  (X1 < X, Y1 < Y) -> D is 7).


/*
Predicados para colocar/mover peças no Tabuleiro
 */
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	X < 1, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
  X > 8, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	Y < 1, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
  Y > 8, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	nth1(Y, OldBoard, OldRow),
	putPieceInRow(OldRow, NRow, X, Piece),
	putRowInBoard(OldBoard, NewBoard, Y, NRow).

putPieceInRow([_|OldRow], [Piece|OldRow], 1, Piece).
putPieceInRow([_R|OldRow], [_R|NewRow], X, Piece):-
  X1 is X - 1,
  putPieceInRow(OldRow, NewRow, X1, Piece).

putRowInBoard([_|OldBoard], [Row|OldBoard], 1, Row).
putRowInBoard([_R|OldBoard], [_R|NewBoard], Y, Row):-
  Y1 is Y - 1,
  putRowInBoard(OldBoard, NewBoard, Y1, Row).

/*
Predicado para converter letra (do tabuleiro)
em numero (na lista tabuleiro)
*//*
convertLetterToNum('a', 1).
convertLetterToNum('b', 2).
convertLetterToNum('c', 3).
convertLetterToNum('d', 4).
convertLetterToNum('e', 5).
convertLetterToNum('f', 6).
convertLetterToNum('g', 7).
convertLetterToNum('h', 8).
*/
convertLetterToNum(L, N):-
  (L = 'A') -> N is 1;
  (L = 'B') -> N is 2;
  (L = 'C') -> N is 3;
  (L = 'D') -> N is 4;
  (L = 'E') -> N is 5;
  (L = 'F') -> N is 6;
  (L = 'G') -> N is 7;
  (L = 'H') -> N is 8.

/*
Predicado que atualiza o tabuleiro
*/
updateBoardSimpleMove(OldBoard, NewBoard, X-Y, NewX-NewY, Player):-
write('Update Board'),nl,	
putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
write('Nao ha error no ut'),nl,
	putPiece(_UpdatedBoard, NewBoard, NewX-NewY, Player),
write('Nao ha error no ut'),nl.

updateBoardCaptureMove(OldBoard, NewBoard, X-Y, NewX-NewY, Player):-
  putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
  ite(X = NewX,
    X1 is X,
    (ite(X > NewX, X1 is NewX + 1, X1 is NewX - 1))),

  ite(Y = NewY,
    Y1 is Y,
    (ite(Y > NewY, Y1 is NewY + 1, Y1 is NewY - 1))),

  putPiece(_UpdatedBoard, _UpdatedBoard2, X1-Y1, 0),%apagar o capturado
  putPiece(_UpdatedBoard2, NewBoard, NewX-NewY, Player).
