/*
Predicado para verificar quais os movimentos
validos de uma peça homem.
Em Move retorna a posição inicial e final da peça.
Os movimentos(vertical ou diagonal) sao sempre para
a frente/em sentido ao extremo adversário.
*/


%movimento vertical
validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, 2):-
	findPiece(CurrBoard, X-Y, Player),
	Y1 is Y + 1,
	findPiece(CurrBoard, X-Y1, 0),
	NewX is X, NewY is Y1.
%movimento linear vertical (salta por cima de pecas do mesmo tipo)
validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, 2):-
  findPiece(CurrBoard, X-Y, Player),
  Y1 is Y + 1,
  findPiece(CurrBoard, X-Y1, Player),
  validMan1Move(CurrBoard, X-Y1, NewX-NewY, Player, 2).

%movimento diagonal esquerda
validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, 1):-
	findPiece(CurrBoard, X-Y, Player),
	X1 is X - 1,
	Y1 is Y + 1,
	findPiece(CurrBoard, X1-Y1, 0),
	NewX is X1, NewY is Y1.
%movimento linear diagonal esquerda (salta por cima de pecas do mesmo tipo)
validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, 1):-
  findPiece(CurrBoard, X-Y, Player),
  X1 is X - 1,
  Y1 is Y + 1,
	findPiece(CurrBoard, X1-Y1, Player),
  validMan1Move(CurrBoard, X1-Y1, NewX-NewY, Player, 1).

%movimento diagonal direita
validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, 3):-
	findPiece(CurrBoard, X-Y, Player),
	X1 is X + 1,
	Y1 is Y + 1,
	findPiece(CurrBoard, X1-Y1, 0),
	NewX is X1, NewY is Y1.
%movimento linear diagonal direita (salta por cima de pecas do mesmo tipo)
validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, 3):-
	findPiece(CurrBoard, X-Y, Player),
    X1 is X + 1,
	Y1 is Y + 1,
	findPiece(CurrBoard, X1-Y1, Player),
	validMan1Move(CurrBoard, X1-Y1, NewX-NewY, Player, 3).
/*
validMan1Move(CurrBoard, X-Y, NewX-NewY, Player, D):-
	fail.
*/

%movimento vertical
validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, 8):-
	findPiece(CurrBoard, X-Y, Player),
	Y1 is Y - 1,
	findPiece(CurrBoard, X-Y1, 0),
	NewX is X, NewY is Y1.
%movimento linear vertical (salta por cima de pecas do mesmo tipo)
validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, 8):-
  findPiece(CurrBoard, X-Y, Player),
  Y1 is Y - 1,
  findPiece(CurrBoard, X-Y1, Player),
  validMan2Move(CurrBoard, X-Y1, NewX-NewY, Player, 8).

%movimento diagonal esquerda
validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, 4):-
	findPiece(CurrBoard, X-Y, Player),
	X1 is X - 1,
	Y1 is Y - 1,
	findPiece(CurrBoard, X1-Y1, 0),
	NewX is X1, NewY is Y1.
%movimento linear diagonal esquerda (salta por cima de pecas do mesmo tipo)
validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, 4):-
  findPiece(CurrBoard, X-Y, Player),
  X1 is X - 1,
  Y1 is Y - 1,
	findPiece(CurrBoard, X1-Y1, Player),
  validMan2Move(CurrBoard, X1-Y1, NewX-NewY, Player, 4).

%movimento diagonal direita
validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, 6):-
	findPiece(CurrBoard, X-Y, Player),
	X1 is X + 1,
	Y1 is Y - 1,
	findPiece(CurrBoard, X1-Y1, 0),
	NewX is X1, NewY is Y1.
%movimento linear diagonal direita (salta por cima de pecas do mesmo tipo)
validMan2Move(CurrBoard, X-Y, NewX-NewY, Player, 6):-
	findPiece(CurrBoard, X-Y, Player),
  X1 is X + 1,
	Y1 is Y - 1,
	findPiece(CurrBoard, X1-Y1, Player),
	validMan2Move(CurrBoard, X1-Y1, NewX-NewY, Player, 6).
