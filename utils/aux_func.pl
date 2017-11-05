ite(If, Then, _Else):-
	If, !, Then.
ite(_If, _Then, Else):-
	Else.

removeCaptures(X-Y, NMoves, [], []).

removeCaptures(X-Y, Position, [OneMove | OtherMoves], UpdatedMoves) :-
	ite(nth1(Position, OneMove, X-Y),
		(removeCaptures(X-Y, Position, OtherMoves, UpdatedMovesAux), append([OneMove], UpdatedMovesAux, UpdatedMoves)),
		removeCaptures(X-Y, Position, OtherMoves, UpdatedMoves)).

abs(X,X) :- X >= 0, !.
abs(X,Y) :- Y is -X.

getBestCaptures([], Aux, Aux, NCaptures).
getBestCaptures([H | T], Best, Aux, NCaptures) :-
	nth1(1, H, NCaptures) -> (
		nth1(4, H, Move), append(Aux, Move, Aux2), getBestCaptures(T, Best, Aux2, NCaptures)
	);
	Best = Aux.
