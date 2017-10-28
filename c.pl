	/* Trabalho */
:-use_module(library(lists)).
/*
 1 - brancas - #
 11 - rei - %
 2 - pretas - @
 22 - rei - &

 Tabuleiro Inicial 
 
[[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,2,2,2,2,0,0],[0,2,2,2,2,2,2,0],[2,2,2,2,2,2,2,2]]

Exemplo, capturas de homens:
[[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]]

Exemplo,
[[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]]
showBoard([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]]).
possivelCapture([[0,0,0,0,0,0,0,0],[22,1,0,22,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]],X-Y,N,NX-NY,22),showBoard(N).

possivelCapture([[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,1,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,1,0,22,0,0,0],[0,0,0,0,0,0,0,0]],X-Y,N,NX-NY,22),showBoard(N).


possivelCapture([[0,0,0,0,0,0,0,0],[22,0,0,22,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]],2-1,N,NX-NY,22),showBoard(N).

possivelCapture([[0,0,0,0,0,0,0,0],[22,1,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]],X-Y,N,NX-NY,22),showBoard(N).

*/
isKing(22).
isKing(11).
/*REIS*/
/*Direction
x- 1
x+ 2
y- 3
y+ 4
*/
possivelCaptureKing(OTab, X-Y, NTab, X-NY, Player, Direction):-%Capturar em Y menos
	Direction = 3,
	findPiece(OTab, X-Y, Player),
	Y1 is Y-1,
	findPiece(OTab, X-Y1, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _N, X-Y1, Player),
	possivelCaptureKing(_N, X-Y1, NTab, X-NY, Player, Direction).
possivelCaptureKing(OTab, X-Y, NTab, X-NY, Player, Direction):-%Capturar em Y mais
	Direction = 4,
	findPiece(OTab, X-Y, Player),
	Y1 is Y+1,
	findPiece(OTab, X-Y1, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _N, X-Y1, Player),
	possivelCaptureKing(_N, X-Y1, NTab, X-NY, Player, Direction).

possivelCaptureKing(OTab, X-Y, NTab, NX-Y, Player, Direction):-%Capturar em X menos
	Direction = 1;
	findPiece(OTab, X-Y, Player),
	X1 is X-1,
	findPiece(OTab, X1-Y, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _N, X1-Y, Player),
	possivelCaptureKing(_N, X1-Y, NTab, NX-Y, Player, Direction).

possivelCaptureKing(OTab, X-Y, NTab, NX-Y, Player, Direction):-%Capturar em X mais
	Direction = 2,
	findPiece(OTab, X-Y, Player),
	X1 is X+1,
	findPiece(OTab, X1-Y, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _N, X1-Y, Player),
	possivelCaptureKing(_N, X1-Y, NTab, NX-Y, Player, Direction).

possivelCaptureKing(OTab, X-Y, NTab, NX-Y, Player, Direction):-%Capturar em X menos
	Direction = 1,
	findPiece(OTab, X-Y, Player),
	X1 is X-1,
	findPiece(OTab, X1-Y, _A),
	adversary(Player, _A),
	NX is X-2,
	findPiece(OTab, NX-Y, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _I1, X1-Y, 0),
	putPiece(_I1, NTab, NX-Y, Player).
possivelCaptureKing(OTab, X-Y, NTab, NX-Y, Player, Direction):-%Capturar em X mais
	Direction = 2,
	findPiece(OTab, X-Y, Player),
	X1 is X+1,
	findPiece(OTab, X1-Y, _A),
	adversary(Player, _A),
	NX is X+2,
	findPiece(OTab, NX-Y, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _I1, X1-Y, 0),
	putPiece(_I1, NTab, NX-Y, Player).
possivelCaptureKing(OTab, X-Y, NTab, X-NY, Player, Direction):-%Capturar em Y mais
	Direction = 4,
	findPiece(OTab, X-Y, Player),
	Y1 is Y+1,
	findPiece(OTab, X-Y1, _A),
	adversary(Player, _A),
	NY is Y+2,
	findPiece(OTab, X-NY, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _I1, X-Y1, 0),
	putPiece(_I1, NTab, X-NY, Player).
possivelCaptureKing(OTab, X-Y, NTab, X-NY, Player, Direction):-%Capturar em Y menos
	Direction = 3,
	findPiece(OTab, X-Y, Player),
	Y1 is Y-1,
	findPiece(OTab, X-Y1, _A),
	adversary(Player, _A),
	NY is Y-2,
	findPiece(OTab, X-NY, 0),
	putPiece(OTab, _I, X-Y, 0),
	putPiece(_I, _I1, X-Y1, 0),
	putPiece(_I1, NTab, X-NY, Player).



possivelCapture(OTab,X-Y,NTab,NX-Y,Player):-
	isKing(Player),!,
	possivelCaptureKing(OTab,X-Y,NTab,NX-NY,Player,Direction).
/*Playeres Normais*/
possivelCapture(OTab,X-Y,NTab,NX-Y,Player):-%Capturar em X menos
	findPiece(OTab,X-Y,Player),
	X1 is X-1,
	findPiece(OTab,X1-Y,_A),
	adversary(Player,_A),
	NX is X-2,
	findPiece(OTab,NX-Y,0),
	putPiece(OTab,_I,X-Y,0),
	putPiece(_I,_I1,X1-Y,0),
	putPiece(_I1,NTab,NX-Y,Player).
possivelCapture(OTab,X-Y,NTab,NX-Y,Player):-%Capturar em X mais
	findPiece(OTab,X-Y,Player),
	X1 is X+1,
	findPiece(OTab,X1-Y,_A),
	adversary(Player,_A),
	NX is X+2,
	findPiece(OTab,NX-Y,0),
	putPiece(OTab,_I,X-Y,0),
	putPiece(_I,_I1,X1-Y,0),
	putPiece(_I1,NTab,NX-Y,Player).
possivelCapture(OTab,X-Y,NTab,X-NY,Player):-%Capturar em Y mais
	findPiece(OTab,X-Y,Player),
	Y1 is Y+1,
	findPiece(OTab,X-Y1,_A),
	adversary(Player,_A),
	NY is Y+2,
	findPiece(OTab,X-NY,0),
	putPiece(OTab,_I,X-Y,0),
	putPiece(_I,_I1,X-Y1,0),
	putPiece(_I1,NTab,X-NY,Player).
possivelCapture(OTab,X-Y,NTab,X-NY,Player):-%Capturar em Y menos
	findPiece(OTab,X-Y,Player),
	Y1 is Y-1,
	findPiece(OTab,X-Y1,_A),
	adversary(Player,_A),
	NY is Y-2,
	findPiece(OTab,X-NY,0),
	putPiece(OTab,_I,X-Y,0),
	putPiece(_I,_I1,X-Y1,0),
	putPiece(_I1,NTab,X-NY,Player).
/*END*/
/**Predicado para encontrar pecas
 */
findPiece(Tab,X-Y,Piece):-
    nth1(X, Tab, Linha),
    nth1(Y, Linha, Piece).

/**Predicado para mexer no Tabuleiro
 * X - Linha
 * Y - Coluna
 */
putPieceLin([_|VLine],[Piece|VLine],1,Piece).
putPieceLin([_R|VLine],[_R|NLine],Y,Piece):-
	Y1 is (Y-1),
	putPieceLin(VLine,NLine,Y1,Piece).
putLinTab([_|OTab],[Lin|OTab],1,Lin).
putLinTab([_R|OTab],[_R|NTab],X,Lin):-
	X1 is (X-1),
	putLinTab(OTab,NTab,X1,Lin).
putPiece(OTab,NTab,X-Y,Piece):-
	X < 1, !, fail.
putPiece(OTab,NTab,X-Y,Piece):-
	X > 8, !, fail.
putPiece(OTab,NTab,X-Y,Piece):-
	Y < 1, !, fail.
putPiece(OTab,NTab,X-Y,Piece):-
	Y > 8, !, fail. 
putPiece(OTab,NTab,X-Y,Piece):-
	nth1(X,OTab,VLinha),
	putPieceLin(VLinha,NLinha,Y,Piece),
	putLinTab(OTab,NTab,X,NLinha).
/*END*/

%adversary(Player,Adversario).
adversary(1,2).
adversary(1,22).
adversary(11,2).
adversary(11,22).
adversary(2,1).
adversary(2,11).
adversary(22,1).
adversary(22,11).

/*Predicado Para Mostrar o Tabuleiro*/
showBoard(X):- showLine(X, 1).
showLine(X,Y):- X = [],
	write(' |A|B|C|D|E|F|G|H|').
showLine(X,Y):- X = [H|R],
	Yn is (Y + 1),
	write(Y),
	showCol(H),nl,
	showLine(R,Yn).
showCol(X):- X = [] , write('|').
showCol(X):- X = [H|R],
	write('|'),	
	showPiece(H),
	showCol(R).
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
