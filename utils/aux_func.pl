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
getBestCaptures([N-L | T], Best, Aux, NCaptures) :-
	N = NCaptures -> (
		append(Aux, L, Aux2), getBestCaptures(T, Best, Aux2, NCaptures)
	);
	Best = Aux.

read(Input) :-
	get_code(Ch),
	getAllChars(Ch, CharsList),
	name(Input, CharsList).

getAllChars(10, []).
getAllChars(13, []).
getAllChars(Ch, [Ch | OtherChars]) :-
	get_code(NewCh),
	getAllChars(NewCh, OtherChars).

read(Integer) :-
	get_code(Ch),
	Digit is (Ch - 48),
	getAllNumbers(Digit, Integer).

getAllNumbers(Aux, Result) :-
	get_code(Ch),
	ite((Ch == 13 ;Ch == 10),
	Result is Aux,
		(
		 NewDigit is (Ch - 48),
		 NewAux is (Aux * 10 + NewDigit),
		 getAllNumbers(NewAux, Result)
		)
	 ).
