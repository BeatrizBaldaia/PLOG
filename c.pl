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


showBoard([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,1,0,0,0,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]]).
setof(Num-X-Y,captureNumber([[0,0,0,0,0,0,0,0],[0,1,0,22,0,0,0,0],[0,0,0,1,0,0,0,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]],X-Y,Num,22),_L), reverse(_L,L).

[[0,2,0,22,0,2,0,1],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,1,0,2,0,1,11]]

gameOver([[0,0,0,0,0,0,0,0],[0,1,0,0,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,0,1,0],[0,11,0,0,0,0,0,1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]],2).
X = [[0,2,0,22,0,2,0,1],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,1,0,2,0,1,11]],showBoard(X),promotedToKing(X,N),showBoard(N).
promotedToKing([[0,2,0,22,0,2,0,1],[0,1,0,22,0,0,0,0],[0,0,0,0,0,0,1,0],[1,0,0,0,0,0,0,0],[0,0,0,0,0,2,1,0],[0,11,2,0,0,0,2,1],[0,0,0,2,0,0,0,0],[0,0,1,0,2,0,1,11]],N),showBoard(N).

Move = [inicialP,P2,P3,..., finalP]

findall(M,validMovePlayer2([[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,2,2,2,2,0,0],[0,2,2,2,2,2,2,0],[2,2,2,2,2,2,2,2]],X-Y,M,D),L).

*/


promotedToKing(OldBoard, NewBoard):-
	promotedToKing1(OldBoard, _UpdatedBoard),
	promotedToKing2(_UpdatedBoard, NewBoard).

promotedToKing1(NewBoard, NewBoard):-
	\+findPiece(NewBoard, 8-Y, 1).
promotedToKing1(OldBoard, NewBoard):-
	findPiece(OldBoard, 8-Y, 1),
	putPiece(OldBoard, _UpdatedBoard, 8-Y, 11),
	promotedToKing1(_UpdatedBoard, NewBoard).

promotedToKing2(OldBoard, OldBoard):-
	\+findPiece(OldBoard, 1-Y, 2).
promotedToKing2(OldBoard, NewBoard):-
	findPiece(OldBoard, 1-Y, 2),
	putPiece(OldBoard, _UpdatedBoard, 1-Y, 22),
	promotedToKing2(_UpdatedBoard, NewBoard).
/*END*/
%adversary(Jogador,Adversario).
adversary(1,2).
adversary(1,22).
adversary(11,2).
adversary(11,22).
adversary(2,1).
adversary(2,11).
adversary(22,1).
adversary(22,11).
isKing(22).
isKing(11).
/*Direction
x- 1
x+ 2
y- 3
y+ 4
*/
possibleCaptureKing(OldBoard, X-Y, NewBoard, NewX-Y, Player, Direction):-%Capturar em X menos
	Direction = 1,
	findPiece(OldBoard, X-Y, Player),
	X1 is X - 1,
	findPiece(OldBoard, X1-Y, _A),
	adversary(Player, _A),
	NewX is X - 2,
	findPiece(OldBoard, NewX-Y, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X1-Y, 0),
	putPiece(_UpdatedBoard2, NewBoard, NewX-Y, Player).
possibleCaptureKing(OldBoard, X-Y, NewBoard, NewX-Y, Player, Direction):-%Capturar em X mais
	Direction = 2,
	findPiece(OldBoard, X-Y, Player),
	X1 is X + 1,
	findPiece(OldBoard, X1-Y, _A),
	adversary(Player, _A),
	NewX is X + 2,
	findPiece(OldBoard, NewX-Y, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X1-Y, 0),
	putPiece(_UpdatedBoard2, NewBoard, NewX-Y, Player).
possibleCaptureKing(OldBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y mais
	Direction = 4,
	findPiece(OldBoard, X-Y, Player),
	Y1 is Y + 1,
	findPiece(OldBoard, X-Y1, _A),
	adversary(Player, _A),
	NewY is Y + 2,
	findPiece(OldBoard, X-NewY, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X-Y1, 0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
possibleCaptureKing(OldBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y menos
	Direction = 3,
	findPiece(OldBoard, X-Y, Player),
	Y1 is Y - 1,
	findPiece(OldBoard, X-Y1, _A),
	adversary(Player, _A),
	NewY is Y - 2,
	findPiece(OldBoard, X-NewY, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X-Y1, 0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
possibleCaptureKing(OldBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y menos
	Direction = 3,
	findPiece(OldBoard, X-Y, Player),
	Y1 is Y-1,
	findPiece(OldBoard, X-Y1, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _N, X-Y1, Player),
	possibleCaptureKing(_N, X-Y1, NewBoard, X-NewY, Player, Direction).
possibleCaptureKing(OldBoard, X-Y, NewBoard, X-NewY, Player, Direction):-%Capturar em Y mais
	Direction = 4,
	findPiece(OldBoard, X-Y, Player),
	Y1 is Y + 1,
	findPiece(OldBoard, X-Y1, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _N, X-Y1, Player),
	possibleCaptureKing(_N, X-Y1, NewBoard, X-NewY, Player, Direction).
possibleCaptureKing(OldBoard, X-Y, NewBoard, NewX-Y, Player, Direction):-%Capturar em X menos
	Direction = 1,
	findPiece(OldBoard, X-Y, Player),
	X1 is X - 1,
	findPiece(OldBoard, X1-Y, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, UpdatedBoard2, X1-Y, Player),
	possibleCaptureKing(UpdatedBoard2, X1-Y, NewBoard, NewX-Y, Player, Direction).
possibleCaptureKing(OldBoard, X-Y, NewBoard, NewX-Y, Player, Direction):-%Capturar em X mais
	Direction = 2,
	findPiece(OldBoard, X-Y, Player),
	X1 is X + 1,
	findPiece(OldBoard, X1-Y, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _N, X1-Y, Player),
	possibleCaptureKing(_N, X1-Y, NewBoard, NewX-Y, Player, Direction).

possibleCapture(OldBoard, X-Y, NewBoard, NewX-NewY, Player):-
	isKing(Player), !,
	possibleCaptureKing(OldBoard, X-Y, NewBoard, NewX-NewY, Player, Direction).
/*Playeres Normais*/
possibleCapture(OldBoard, X-Y, NewBoard, NewX-Y, Player):-%Capturar em X menos
	findPiece(OldBoard, X-Y, Player),
	X1 is X - 1,
	findPiece(OldBoard, X1-Y, _A),
	adversary(Player, _A),
	NewX is X - 2,
	findPiece(OldBoard, NewX-Y, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X1-Y, 0),
	putPiece(_UpdatedBoard2, NewBoard, NewX-Y, Player).
possibleCapture(OldBoard, X-Y, NewBoard, NewX-Y, Player):-%Capturar em X mais
	findPiece(OldBoard, X-Y, Player),
	X1 is X + 1,
	findPiece(OldBoard, X1-Y, _A),
	adversary(Player, _A),
	NewX is X + 2,
	findPiece(OldBoard, NewX-Y, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X1-Y, 0),
	putPiece(_UpdatedBoard2, NewBoard, NewX-Y, Player).
possibleCapture(OldBoard, X-Y, NewBoard, X-NewY, Player):-%Capturar em Y mais
	findPiece(OldBoard, X-Y, Player),
	Y1 is Y + 1,
	findPiece(OldBoard, X-Y1, _A),
	adversary(Player, _A),
	NewY is Y + 2,
	findPiece(OldBoard, X-NewY, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X-Y1, 0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
possibleCapture(OldBoard, X-Y, NewBoard, X-NewY, Player):-%Capturar em Y menos
	findPiece(OldBoard, X-Y, Player),
	Y1 is Y - 1,
	findPiece(OldBoard, X-Y1, _A),
	adversary(Player, _A),
	NewY is Y - 2,
	findPiece(OldBoard, X-NewY, 0),
	putPiece(OldBoard, _UpdatedBoard, X-Y, 0),
	putPiece(_UpdatedBoard, _UpdatedBoard2, X-Y1, 0),
	putPiece(_UpdatedBoard2, NewBoard, X-NewY, Player).
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
putPieceInRow([_|OldRow], [Piece|OldRow], 1, Piece).
putPieceInRow([_R|OldRow], [_R|NewRow], Y, Piece):-
	Y1 is (Y-1),
	putPieceInRow(OldRow, NewRow, Y1, Piece).
putRowInBoard([_|OldBoard], [Lin|OldBoard], 1, Lin).
putRowInBoard([_R|OldBoard], [_R|NewBoard], X, Lin):-
	X1 is (X-1),
	putRowInBoard(OldBoard, NewBoard, X1, Lin).
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	X < 1, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	X > 8, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	Y < 1, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	Y > 8, !, fail.
putPiece(OldBoard, NewBoard, X-Y, Piece):-
	nth1(X, OldBoard, OldRow),
	putPieceInRow(OldRow, NLinha, Y, Piece),
	putRowInBoard(OldBoard, NewBoard, X, NLinha).
/*END*/

/*Predicado Para Mostrar o Tabuleiro*/
showBoard(X):- showRow(X, 1).
showRow(X, Y):- X = [],
	write('--------------------------------------'), nl,
	write('     |_A_|_B_|_C_|_D_|_E_|_F_|_G_|_H_|').
showRow(X, Y):- X = [H|R],
	Yn is (Y + 1),
	write('--------------------------------------'), nl,
	write('| '),
	write(Y),
	showRowValues(H), nl,
	showRow(R, Yn).
showRowValues(X):- X = [] , write(' |').
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
captureNumber(OldBoard, X-Y, 0, Player):-
	\+possibleCapture(OldBoard, X-Y, NewBoard, NewX-NewY, Player).

captureNumber(OldBoard, X-Y, Num, Player):-
	possibleCapture(OldBoard, X-Y, NewBoard, NewX-NewY, Player),
	captureNumber(NewBoard, NewX-NewY, NNum, Player),
	Num is NNum+1.
validMove(OTab, X-Y, Move, 1):-
	validMovePlayer1(OTab, X-Y, Move, D).
validMove(OTab, X-Y, Move, 2):-
	validMovePlayer2(OTab, X-Y, Move, D).

validMovePlayer2(OTab, X-Y, Move, y0):-
	findPiece(OTab, X-Y, 2),
	X1 is X-1,
	findPiece(OTab, X1-Y, 0),
	Move = [X-Y,X1-Y].
validMovePlayer2(OTab, X-Y, Move, y-):-
	findPiece(OTab, X-Y, 2),
	X1 is X-1,
	Y1 is Y-1,
	findPiece(OTab, X1-Y1, 0),
	Move = [X-Y,X1-Y1].
validMovePlayer2(OTab, X-Y, Move, y+):-
	findPiece(OTab, X-Y, 2),
	X1 is X-1,
	Y1 is Y+1,
	findPiece(OTab, X1-Y1, 0),
	Move = [X-Y,X1-Y1].

validMovePlayer2(OTab, X-Y, [Move|Continue], y+):-
	findPiece(OTab, X-Y, 2),
	X1 is X-1,
	Y1 is Y+1,
	findPiece(OTab, X1-Y1, 2),
	Move = [X-Y],
	validMovePlayer2(OTab, X1-Y1, [Mov1|Continue], y+).
validMovePlayer2(OTab, X-Y, [Move|Continue], y-):-
	findPiece(OTab, X-Y, 2),
	X1 is X-1,
	Y1 is Y-1,
	findPiece(OTab, X1-Y1, 2),
	Move = [X-Y],
	validMovePlayer2(OTab, X1-Y1, [Mov1|Continue], y-).
validMovePlayer2(OTab, X-Y, [Move|Continue], y0):-
	findPiece(OTab, X-Y, 2),
	X1 is X-1,
	findPiece(OTab, X1-Y1, 2),
	Move = [X-Y],
	validMovePlayer2(OTab, X1-Y, [Mov1|Continue], y0).








validMovePlayer1(OTab, X-Y, Move, y0):-
	findPiece(OTab, X-Y, 1),
	X1 is X+1,
	findPiece(OTab, X1-Y, 0),
	Move = [X-Y,X1-Y].
validMovePlayer1(OTab, X-Y, Move, y-):-
	findPiece(OTab, X-Y, 1),
	X1 is X+1,
	Y1 is Y-1,
	findPiece(OTab, X1-Y1, 0),
	Move = [X-Y,X1-Y1].
validMovePlayer1(OTab, X-Y, Move, y+):-
	findPiece(OTab, X-Y, 1),
	X1 is X+1,
	Y1 is Y+1,
	findPiece(OTab, X1-Y1, 0),
	Move = [X-Y,X1-Y1].

validMovePlayer1(OTab, X-Y, [Move|Continue], y+):-
	findPiece(OTab, X-Y, 1),
	X1 is X+1,
	Y1 is Y+1,
	findPiece(OTab, X1-Y1, 1),
	Move = [X-Y],
	validMovePlayer1(OTab, X1-Y1, [Mov1|Continue], y+).
validMovePlayer1(OTab, X-Y, [Move|Continue], y-):-
	findPiece(OTab, X-Y, 1),
	X1 is X+1,
	Y1 is Y-1,
	findPiece(OTab, X1-Y1, 1),
	Move = [X-Y],
	validMovePlayer1(OTab, X1-Y1, [Mov1|Continue], y-).
validMovePlayer1(OTab, X-Y, [Move|Continue], y0):-
	findPiece(OTab, X-Y, 1),
	X1 is X+1,
	findPiece(OTab, X1-Y1, 1),
	Move = [X-Y],
	validMovePlayer1(OTab, X1-Y, [Mov1|Continue], y0).

play:-
	state(InitialPlayer, InicialTab),
	assert(state(InitialPlayer, InicialTab)),
	repeat,
		retract(state(Player, Tab)),
		once(playGame(Player, OTab, NPlayer, NTab)),
		assert(state(NPlayer, NTab),
		gameOver(NTab,NPlayer),
		showResult(NTab,NPlayer).
playGame(Player, OTab, NPlayer, NTab):-
	validMoves(OTab, Player, Moves),
	bestMove(Player, Moves, Best),
	move(OTab, Best, NTab),
	nextPlayer(Player, NPlayer).
playGame(Player, OTab, NPlayer, NTab):-
	validMoves(OTab, Player, Moves),
	askMove(Player, OTab, Move),%	member(Move, Moves),
	move(OTab, Move, NTab),
	nextPlayer(Player, NPlayer).

validMoves(OTab, Player, Moves).%TODO Errado.
validMoves(OTab, Player, Moves):-
	setof(Num-X-Y,captureNumber(OTab,X-Y,Num,Player),_L), 
	reverse(_L,L).
gameOver(OldBoard, Player):- findPiece(OldBoard, _X-_Y, Player), validMoves(OldBoard, Player, Moves), !, fail.
gameOver(_OldBoard, _Player).

