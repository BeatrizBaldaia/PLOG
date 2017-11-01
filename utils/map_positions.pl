/*
Predicado para encontrar pecas
*/
findPiece(Board, X-Y, Piece):-
    nth1(Y, Board, Row),
    nth1(X, Row, Piece).

/*
Predicado para obter a direcao de um movimento simples
*/
getManDirection(Player, X-Y, X1-Y1, D):-
  X > X1 -> D is 4;
  X < X1 -> D is 6;
  Player = 1 -> (
    D is 2
  );
    D is 8.

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
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, NewBoard, NewX-NewY, Player).
