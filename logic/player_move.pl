validMovesPC(Board, Player, Moves, no):-
	mandatoryCapturePC(Board, Player, Moves).
validMovesPC(Board, Player, Moves, yes):-
	findall(Move,validMovePC(Board, Player, Move),Moves).
validMovePC(Board, Player, [X-Y,NewX-NewY]):-
	ite(Player = 1,
	validMan1Move(Board, X-Y, NewX-NewY, D),
	validMan2Move(Board, X-Y, NewX-NewY, D)).
validMovePC(Board, Player, [X-Y,NewX-NewY]):-
	ite(Player = 1,
	validKingMove(Board, X-Y, NewX-NewY, 11, D),
	validKingMove(Board, X-Y, NewX-NewY, 22, D)).

