	/* Trabalho */
:-use_module(library(lists)).
/*
 1 - brancas - #
 11 - rei - %
 2 - pretas - @
 22 - rei - &

 Tabuleiro Inicial

[[1, 1, 1, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1, 1, 0], [0, 0, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 2, 2, 2, 2, 0, 0], [0, 2, 2, 2, 2, 2, 2, 0], [2, 2, 2, 2, 2, 2, 2, 2]]

Exemplo:
[[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 0], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]]

possibleCapture([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 0], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], 5-6, N, NewX-NewY, 2), showBoard(N).
possibleCapture([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 0], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], 6-3, N, NewX-NewY, 2), showBoard(N).
possibleCapture([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 0], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], 6-7, N, NewX-NewY, 2), showBoard(N).
possibleCapture([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 2], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], 5-8, N, NewX-NewY, 2), showBoard(N).

possibleCapture([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 2], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], X-Y, N, NewX-NewY, 2), showBoard(N).
possibleCapture([[1, 1, 1, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1, 1, 0], [0, 0, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 2, 2, 2, 2, 0, 0], [0, 2, 2, 2, 2, 2, 2, 0], [2, 2, 2, 2, 2, 2, 2, 2]], X-Y, N, NewX-NewY, 2), showBoard(N).

captureNumber([[1, 1, 1, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1, 1, 0], [0, 0, 1, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 2, 2, 2, 2, 0, 0], [0, 2, 2, 2, 2, 2, 2, 0], [2, 2, 2, 2, 2, 2, 2, 2]], X-Y, Num, 2).
captureNumber([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 2], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], X-Y, Num, 2).

putPiece([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 0], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], N, 8-8, 22), showBoard(N).

findall(Num-X-Y, captureNumber([[0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 22, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 1, 0], [0, 11, 2, 0, 0, 0, 2, 1], [0, 0, 0, 2, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 0, 0]], X-Y, Num, 2), L).



captureNumber([[0, 0, 0, 0, 0, 0, 0, 0], [0, 2, 1, 0, 1, 0, 0, 0], [0, 1, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]], X-Y, Num, 2).

*/
%adversary(Jogador, Adversario).
adversary(1, 2).
adversary(1, 22).
adversary(11, 2).
adversary(11, 22).
adversary(2, 1).
adversary(2, 11).
adversary(22, 1).
adversary(22, 11).
isKing(22).
isKing(11).
/*Direction
x- 1
x+ 2
y- 3
y+ 4
*/
possibleCaptureKing(CurrBoard, X-Y, NewBoard, NewX-Y, Player, Direction):-%Capturar em X menos
	Direction = 1,
	findPiece(CurrBoard, X-Y, Player),
	X1 is X - 1,
	findPiece(CurrBoard, X1-Y, _A),
	adversary(Player, _A),
	NewX is X - 2,
	findPiece(CurrBoard, NewX-Y, 0),
	putPiece(CurrBoard, _UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X1-Y, 0),
	putPiece(_UpdatedBoard2,  NewBoard,  NewX-Y,  Player).
possibleCaptureKing(CurrBoard,  X-Y,  NewBoard,  NewX-Y,  Player,  Direction):-%Capturar em X mais
	Direction = 2,
	findPiece(CurrBoard,  X-Y,  Player),
	X1 is X + 1,
	findPiece(CurrBoard,  X1-Y,  _A),
	adversary(Player,  _A),
	NewX is X + 2,
	findPiece(CurrBoard,  NewX-Y,  0),
	putPiece(CurrBoard, _UpdatedBoard1,  X-Y,  0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2,  X1-Y,  0),
	putPiece(_UpdatedBoard2, NewBoard, NewX-Y, Player).
possibleCaptureKing(CurrBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y mais
	Direction = 4,
	findPiece(CurrBoard, X-Y, Player),
	Y1 is Y + 1,
	findPiece(CurrBoard, X-Y1, _A),
	adversary(Player, _A),
	NewY is Y + 2,
	findPiece(CurrBoard,  X-NewY,  0),
	putPiece(CurrBoard, _UpdatedBoard1,  X-Y,  0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2,  X-Y1,  0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
possibleCaptureKing(CurrBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y menos
	Direction = 3,
	findPiece(CurrBoard, X-Y, Player),
	Y1 is Y - 1,
	findPiece(CurrBoard,  X-Y1, _A),
	adversary(Player, _A),
	NewY is Y-2,
	findPiece(CurrBoard, X-NewY, 0),
	putPiece(CurrBoard, _UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X-Y1,  0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
possibleCaptureKing(CurrBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y menos
	Direction = 3,
	findPiece(CurrBoard,  X-Y,  Player),
	Y1 is Y - 1,
	findPiece(CurrBoard, X-Y1, 0),
	putPiece(CurrBoard, _UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X-Y1, Player),
	possibleCaptureKing(_UpdatedBoard2, X-Y1, NewBoard, X-NewY, Player, Direction).
possibleCaptureKing(CurrBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y mais
	Direction = 4,
	findPiece(CurrBoard,  X-Y,  Player),
	Y1 is Y + 1,
	findPiece(CurrBoard, X-Y1,  0),
	putPiece(CurrBoard, _UpdatedBoard1, X-Y,  0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X-Y1, Player),
	possibleCaptureKing(_UpdatedBoard2, X-Y1, NewBoard, X-NewY, Player, Direction).
possibleCaptureKing(CurrBoard, X-Y, NewBoard, NewX-Y, Player, Direction):-%Capturar em X menos
	Direction = 1,
	findPiece(CurrBoard, X-Y,  Player),
	X1 is X-1,
	findPiece(CurrBoard, X1-Y,  0),
	putPiece(CurrBoard, _I, X-Y,  0),
	putPiece(_I, P, X1-Y, Player),
	possibleCaptureKing(P, X1-Y, NewBoard, NewX-Y, Player, Direction).
possibleCaptureKing(CurrBoard,  X-Y,  NewBoard, NewX-Y, Player, Direction):-%Capturar em X mais
	Direction = 2,
	findPiece(CurrBoard, X-Y, Player),
	X1 is X + 1,
	findPiece(CurrBoard, X1-Y, 0),
	putPiece(CurrBoard, _UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X1-Y, Player),
	possibleCaptureKing(_UpdatedBoard2, X1-Y, NewBoard, NewX-Y, Player, Direction).

possibleCapture(CurrBoard, X-Y, NewBoard, NewX-NewY, Player) :-
	isKing(Player),  !,
	possibleCaptureKing(CurrBoard, X-Y, NewBoard, NewX-NewY, Player, Direction).
/*Playeres Normais*/
possibleCapture(CurrBoard, X-Y, NewBoard, NewX-Y, Player):-%Capturar em X menos
	findPiece(CurrBoard, X-Y, Player),
	X1 is X - 1,
	findPiece(CurrBoard, X1-Y, _A),
	adversary(Player, _A),
	NewX is X - 2,
	findPiece(CurrBoard, NewX-Y, 0),
	putPiece(CurrBoard, _UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X1-Y, 0),
	putPiece(_UpdatedBoard2, NewBoard, NewX-Y, Player).
possibleCapture(CurrBoard, X-Y, NewBoard, NewX-Y, Player):-%Capturar em X mais
	findPiece(CurrBoard, X-Y, Player),
	X1 is X + 1,
	findPiece(CurrBoard, X1-Y, _A),
	adversary(Player, _A),
	NewX is X + 2,
	findPiece(CurrBoard, NewX-Y, 0),
	putPiece(CurrBoard, __UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X1-Y, 0),
	putPiece(_UpdatedBoard2, NewBoard, NewX-Y, Player).
possibleCapture(CurrBoard, X-Y, NewBoard, X-NewY, Player):-%Capturar em Y mais
	findPiece(CurrBoard, X-Y, Player),
	Y1 is Y + 1,
	findPiece(CurrBoard, X-Y1, _A),
	adversary(Player, _A),
	NewY is Y + 2,
	findPiece(CurrBoard, X-NewY, 0),
	putPiece(CurrBoard, __UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X-Y1, 0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
possibleCapture(CurrBoard, X-Y, NewBoard, X-NewY, Player):-%Capturar em Y menos
	findPiece(CurrBoard, X-Y, Player),
	Y1 is Y - 1,
	findPiece(CurrBoard, X-Y1, _A),
	adversary(Player, _A),
	NewY is Y - 2,
	findPiece(CurrBoard, X-NewY, 0),
	putPiece(CurrBoard, _UpdatedBoard1, X-Y, 0),
	putPiece(_UpdatedBoard1, _UpdatedBoard2, X-Y1, 0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
/*END*/

/**Predicado para encontrar pecas
 */
findPiece(Tab, X-Y, Piece):-
    nth1(X, Tab, Rowha),
    nth1(Y, Rowha, Piece).

/**Predicado para mexer no Tabuleiro
 * Row - Linha
 * Column - Coluna
 */
putPieceInRow([_|OldRow], [Piece|OldRow], 1, Piece).
putPieceInRow([_Pos|OldRow], [_Pos|NewRow], Column, Piece):-
	Column1 is (Column - 1),
	putPieceInRow(OldRow, NewRow, Column1, Piece).
putRowInBoard([_|OldBoard], [Row|OldBoard], 1, Row).
putRowInBoard([_Row|OldBoard], [_Row|NewBoard], NumRow, Row):-
	NumRow1 is (NumRow - 1),
	putRowInBoard(OldBoard, NewBoard, NumRow1, Row).
putPiece(CurrBoard, NewBoard, X-Y, Piece):-
	X < 1,  !,  fail.
putPiece(CurrBoard, NewBoard, X-Y, Piece):-
	X > 8,  !,  fail.
putPiece(CurrBoard, NewBoard, X-Y, Piece):-
	Y < 1,  !,  fail.
putPiece(CurrBoard, NewBoard, X-Y, Piece):-
	Y > 8,  !,  fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	nth1(X, OldBoard, OldRow),
	putPieceInRow(OldRow, NewRow, Y, Piece),
	putRowInBoard(OldBoard, NewBoard, X, NewRow).
/*END*/

/*Predicado Para Mostrar o Tabuleiro*/
showBoard(X):- showRow(X,  1).
showRow(X, Y):- X = [],
	write(' ---------------------------------').
	write(' |_A_|_B_|_C_|_D_|_E_|_F_|_G_|_H_| ').
showRow(X, Y):- X = [H|R],
  write('--------------------------------------'), nl,
	write('| '),
	Yn is (Y + 1),
	write(Y), /*numero da linha*/
	write(' |')
	showRowValues(H), nl,
	showRow(R, Yn).
showRowValues(X):- X = [] ,  write(' | '). /*fim de uma linha*/
showRowValues(X):- X = [H|R],
	write(' | '),
	showPiece(H),
	showRowValues(R).
showPiece(X):- X = 1,
	write('#').
showPiece(X):- X = 2,
	write('@').
showPiece(X):- X = 0,
	write(' ').
showPiece(X):- X = 11,
	write('%').
showPiece(X):- X = 22,
	write('&').
/*END*/
captureNumber(CurrBoard, X-Y, 0, Player):-
	\+possibleCapture(CurrBoard, X-Y, NewBoard, NewX-NewY, Player).

captureNumber(CurrBoard, X-Y, Num, Player):-
	possibleCapture(CurrBoard, X-Y, NewBoard, NewX-NewY, Player),
	captureNumber(NewBoard, NewX-NewY, NNum, Player),
	Num is NNum + 1.
