	/* Trabalho */
:-use_module(library(lists)).
/*
 1 - brancas - #
 11 - rei - %
 2 - pretas - @
 22 - rei - &

 Tabuleiro Inicial 
 
[[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,2,2,2,2,0,0],[0,2,2,2,2,2,2,0],[2,2,2,2,2,2,2,2]]

Exemplo:
[[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]]

possivelCapture([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],5-6,N,NX-NY,2),showBoard(N).
possivelCapture([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],6-3,N,NX-NY,2),showBoard(N).
possivelCapture([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],6-7,N,NX-NY,2),showBoard(N).
possivelCapture([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,2],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],5-8,N,NX-NY,2),showBoard(N).

possivelCapture([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,2],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],X-Y,N,NX-NY,2),showBoard(N).
possivelCapture([[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,2,2,2,2,0,0],[0,2,2,2,2,2,2,0],[2,2,2,2,2,2,2,2]],X-Y,N,NX-NY,2),showBoard(N).

captureNumber([[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,2,2,2,2,0,0],[0,2,2,2,2,2,2,0],[2,2,2,2,2,2,2,2]],X-Y,Num,2).
captureNumber([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,2],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],X-Y,Num,2).

putPiece([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],N,8-8,22),showBoard(N).

findall(Num-X-Y,captureNumber([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,0,0,2,0,0,0]],6-7,Num,2),L).

*/
%adversary(Jogador,Adversario).
adversary(1,2).
adversary(1,22).
adversary(11,2).
adversary(11,22).
adversary(2,1).
adversary(2,11).
adversary(22,1).
adversary(22,11).
/*Jogadores Normais*/
possivelCapture(VTab,X-Y,NTab,NX-Y,Jogador):-%Capturar em X menos
	findPiece(VTab,X-Y,_P),
	_P = Jogador,
	X1 is X-1,
	findPiece(VTab,X1-Y,_A),
	adversary(Jogador,_A),
	NX is X-2,
	findPiece(VTab,NX-Y,_L),
	_L is 0, %livre
	putPiece(VTab,_I,X-Y,0),
	putPiece(_I,_I1,X1-Y,0),
	putPiece(_I1,NTab,NX-Y,Jogador).
possivelCapture(VTab,X-Y,NTab,NX-Y,Jogador):-%Capturar em X mais
	findPiece(VTab,X-Y,_P),
	_P = Jogador,
	X1 is X+1,
	findPiece(VTab,X1-Y,_A),
	adversary(Jogador,_A),
	NX is X+2,
	findPiece(VTab,NX-Y,_L),
	_L is 0, %livre
	putPiece(VTab,_I,X-Y,0),
	putPiece(_I,_I1,X1-Y,0),
	putPiece(_I1,NTab,NX-Y,Jogador).
possivelCapture(VTab,X-Y,NTab,X-NY,Jogador):-%Capturar em Y mais
	findPiece(VTab,X-Y,_P),
	_P = Jogador,
	Y1 is Y+1,
	findPiece(VTab,X-Y1,_A),
	adversary(Jogador,_A),
	NY is Y+2,
	findPiece(VTab,X-NY,_L),
	_L is 0, %livre
	putPiece(VTab,_I,X-Y,0),
	putPiece(_I,_I1,X-Y1,0),
	putPiece(_I1,NTab,X-NY,Jogador).
possivelCapture(VTab,X-Y,NTab,X-NY,Jogador):-%Capturar em Y menos
	findPiece(VTab,X-Y,_P),
	_P = Jogador,
	Y1 is Y-1,
	findPiece(VTab,X-Y1,_A),
	adversary(Jogador,_A),
	NY is Y-2,
	findPiece(VTab,X-NY,_L),
	_L is 0, %livre
	putPiece(VTab,_I,X-Y,0),
	putPiece(_I,_I1,X-Y1,0),
	putPiece(_I1,NTab,X-NY,Jogador).

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
putLinTab([_|VTab],[Lin|VTab],1,Lin).
putLinTab([_R|VTab],[_R|NTab],X,Lin):-
	X1 is (X-1),
	putLinTab(VTab,NTab,X1,Lin).	
putPiece(VTab,NTab,X-Y,Piece):-
	nth1(X,VTab,VLinha),
	putPieceLin(VLinha,NLinha,Y,Piece),
	putLinTab(VTab,NTab,X,NLinha).
/*END*/

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
/*captureNumber(VTab,X-Y,0,Jogador):-
	\+possivelCapture(VTab,X-Y,NTab,NX-NY,Jogador).

captureNumber(VTab,X-Y,Num,Jogador):-
	possivelCapture(VTab,X-Y,NTab,NX-NY,Jogador),
	%captureNumber(NTan,NX-NY,NNum,Jogador),
	Num is 1.

captureNumber(VTab,X-Y,Num,Jogador):-
	captureNumAux(VTab,X-Y,Num,Jogador,0).

captureNumberAux(VTab,X-Y,Acc,Jogador,Acc):-
	\+possivelCapture(VTab,X-Y,NTab,NX-NY,Jogador).

captureNumAux(VTab,X-Y,Num,Jogador,Acc):-
	possivelCapture(VTab,X-Y,NTab,NX-NY,Jogador),
	Acc1 is Acc+1,
	captureNumAux(NTab,NX-NY,Num,Jogador,Acc1).
*/
captureNumber(VTab,X-Y,Num,Jogador):-
	captureNumberAUX(VTab,X-Y,Num,Jogador,NTab,NX-NY).

captureNumberAUX(VTab,X-Y,Num,Jogador,NTab,NX-NY):-
	showBoard(VTab),
	ith(possivelCapture(VTab,X-Y,NTab,NX-NY,Jogador),
		(captureNumberAUX(NTan,NX-NY,NNum,Jogador,NNTab,NNX-NNY),Num is NNum + 1),
		(Num is 0)).

ith(If,Them,_Else):-
	If,
	!,
	Them.
ith(_If,_Them,Else):- 
	Else.














