
/*
Predicado para verificar se a peça
vai ser promovida a rei
*/
promotedToKing(OldBoard, NewBoard):-
	write('First'),nl,
	promotedToKing1(OldBoard, _UpdatedBoard),
		write('set'),nl,
	promotedToKing2(_UpdatedBoard, NewBoard).

promotedToKing1(OldBoard, NewBoard):-
	write('Entrou 1'),nl,
	ite(findPiece(OldBoard, X-8, 1),
		(write('QTF'),nl, putPiece(OldBoard, _UpdatedBoard, X-8, 11),
		promotedToKing1(_UpdatedBoard, NewBoard)),
	(write('return'),nl,NewBoard = OldBoard)).

promotedToKing2(OldBoard, NewBoard):-
	write('Entrou 2'),nl,
	ite(findPiece(OldBoard, X-1, 2),
		(write('QTF'),nl, putPiece(OldBoard, _UpdatedBoard, X-1, 22),
		promotedToKing2(_UpdatedBoard, NewBoard)),
	(write('return'),nl,NewBoard = OldBoard)).

/*
Verificacao de fim de jogo
*/
%TODO
gameOver(OldBoard, Player):- fail.
/*
gameOver(OldBoard, Player):- findPiece(OldBoard, _X-_Y, Player), validMoves(OldBoard, Player, Moves), !, fail.
gameOver(_OldBoard, _Player).
*/
