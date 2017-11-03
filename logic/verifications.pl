
/*
Predicado para verificar se a peça
vai ser promovida a rei
*/
promotedToKing(OldBoard, NewBoard):-
	write('First'),
	promotedToKing1(OldBoard, _UpdatedBoard),
		write('set'),
	promotedToKing2(_UpdatedBoard, NewBoard).

promotedToKing1(OldBoard, NewBoard):-
	write('Entrou 1'),
	ite(findPiece(OldBoard, X-8, 1),
		(write('QTF'), putPiece(OldBoard, _UpdatedBoard, X-8, 11),
		promotedToKing1(_UpdatedBoard, NewBoard)),
	(write('return'),true)).
promotedToKing2(OldBoard, NewBoard):-
	ite(findPiece(OldBoard, X-1, 2),
		(putPiece(OldBoard, _UpdatedBoard, X-1, 22),
		promotedToKing1(_UpdatedBoard, NewBoard)),
	true).
/*
promotedToKing1(NewBoard, NewBoard):-
	write('Nao ha reis'), nl,
	\+findPiece(NewBoard, X-8, 1).
promotedToKing1(OldBoard, NewBoard):-
	write('ha reis'), nl,
	findPiece(OldBoard, X-8, 1),
	putPiece(OldBoard, _UpdatedBoard, X-8, 11),
	promotedToKing1(_UpdatedBoard, NewBoard).

promotedToKing2(OldBoard, OldBoard):-
	\+findPiece(OldBoard, X-1, 2).
promotedToKing2(OldBoard, NewBoard):-
	findPiece(OldBoard, X-1, 2),
	putPiece(OldBoard, _UpdatedBoard, X-1, 22),
	promotedToKing2(_UpdatedBoard, NewBoard).
*/
/*
Verificacao de fim de jogo
*/
%TODO
gameOver(OldBoard, Player):- fail.
/*
gameOver(OldBoard, Player):- findPiece(OldBoard, _X-_Y, Player), validMoves(OldBoard, Player, Moves), !, fail.
gameOver(_OldBoard, _Player).
*/
