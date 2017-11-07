chooseMovePC(Moves, Move):-
	random_member(Move, Moves).%Nivel 1


chooseMovePC(Moves, Move, Level, Board, Player, Simple):-
  ite(Level = 1,
		chooseMovePC(Moves, Move),
		chooseMovePC(Moves, Move, Board, Player, Simple)).

chooseMovePC(Moves, Move, Board, Player, Simple):-
	parserMovePC(Moves,	Board, Player, Simple, Answer),
<<<<<<< HEAD
	%ordemar Answer
=======
	write(Answer),
	sort(Answer, _L),
	write(_L),
>>>>>>> ffbc55e28dfe44d9254342bd64752f0845519ab9
	reverse(_L,[Num-Move|_Rest]).

parserMovePC([], Board, Player, Simple, []).
parserMovePC([Move|Rest], Board, Player, Simple, [Value-Move|ACC]):-
	changeBoard(Board, Move, Player, Simple, Value),
	parserMovePC(Rest, Board, Player, Simple, ACC).

changeBoard(Board, Move, Player, Simple, Value):-
	applyMovePC(Board, NewBoard, Move, Player, Simple),
	boardValue(NewBoard, Player, Value).

boardValue(Board, Player, Value):-
	boardValue(Board, 1, Player, Value1, 0),
	ite(Player = 1, Ad = 2, Ad = 1),
	setof(Num,captureNumber(Board, X-Y, Num, Ad, Move),_L),
	reverse(_L,[Num|_Rest]),
	Value2 is -Num*40,
	Value is Value1 - Value2.

boardValue(Board, 9, Player, Value, Value).
boardValue(Board, Y, Player, Value, Acc):-
	nth1(Y, Board, Line),
	lineValue(Line, 1-Y, Player, ValueLine, 0),
	Y1 is Y+1,
	Acc1 is ValueLine + Acc,
	boardValue(Board, Y1, Player, Value, Acc1).

lineValue(Line, 9-Y, Player, Value, Value).
lineValue(Line, X-Y, Player, FinalValue, Acc):-
	nth1(X, Line, Piece),
	valuePiece(Piece, Y, Num),
	ite(adversary(Player, Piece),
		Value is -Num,
		Value is Num),
	X1 is X+1,
	Acc1 is Value + Acc,
	lineValue(Line, X1-Y, Player, FinalValue, Acc1).

valuePiece(0, _Y, 0).
valuePiece(1, Y, Y).
valuePiece(2, Y, V):- V is 9-Y.
valuePiece(11, _Y, 30).
valuePiece(22, _Y, 30).

/*

['start_example.pl'],boardValue([[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,2,2,2,2,0,0],[0,2,2,2,2,2,2,0],[2,2,2,2,2,2,2,2]], 1, Value).
Value: 0

['start_example.pl'],boardValue([[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,2,2,2,2,0,0],[0,2,2,2,2,2,2,0],[2,2,2,2,2,2,2,2]], 2, Value).
Value: 0

['start_example.pl'],boardValue([[0,0,0,0,0,0,0,0],[0,0,2,0,0,0,0,0],[1,0,1,0,0,22,0,0],[0,0,0,0,0,0,0,0],[0,0,0,11,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,1,0,0,0,0],[0,0,0,0,0,2,0,0]], 1, Value).
Value: 45
['start_example.pl'],boardValue([[0,0,0,0,0,0,0,0],[0,0,2,0,0,0,0,0],[1,0,1,0,0,22,0,0],[0,0,0,0,0,0,0,0],[0,0,0,11,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,1,0,0,0,0],[0,0,0,0,0,2,0,0]], 2, Value).
Value: 35

[[0,0,0,0,0,0,0,0]
,[0,0,2,0,0,0,0,0]
,[1,0,1,0,0,22,0,0]
,[0,0,0,0,0,0,0,0]
,[0,0,0,11,0,0,0,0]
,[0,0,0,0,0,0,0,0]
,[0,0,0,1,0,0,0,0]
,[0,0,0,0,0,2,0,0]]
*/
