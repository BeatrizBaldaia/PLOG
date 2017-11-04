chooseMovePC(Moves, Move):-
	random_member(Move, Moves).%Nivel 1

/**
chooseMovePC(Moves, Move, Level, Board):-
  ite(Level = 1,
		%Nivel1
)
chooseMovePC(Moves, Move, Board):-
*/


/*

boardValue(Board, Player, Value):-
	numberOfPieces(Board, Player, _V).


numberOfPieces(Board, Player, _V):-
	append(Board, List),
	count(List, _V).

count([], 0, Player).
count([H,L], V, Pl):-*/
