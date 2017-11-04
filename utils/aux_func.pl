ite(If, Then, _Else):-
	If, !, Then.
ite(_If, _Then, Else):-
	Else.

removeCaptures(X-Y, NMoves, [], []).

removeCaptures(X-Y, Position, [OneMove | OtherMoves], UpdatedMoves) :-
	ite(nth1(Position, OneMove, X-Y),
		(removeCaptures(X-Y, Position, OtherMoves, UpdatedMovesAux), append([OneMove], UpdatedMovesAux, UpdatedMoves)),
		removeCaptures(X-Y, Position, OtherMoves, UpdatedMoves)).
