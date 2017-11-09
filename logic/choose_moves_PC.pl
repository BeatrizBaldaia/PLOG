chooseMovePCLevel1(Moves, Move):-
	random_member(Move, Moves).%Nivel 1


chooseMovePC(Moves, Move, Level, Board, Player, Simple):-
  ite(Level = 1,
		chooseMovePCLevel1(Moves, Move),
		chooseMovePCLevel2(Moves, Move, Board, Player, Simple)).

chooseMovePCLevel2(Moves, Move, Board, Player, Simple):-
	parserMovePC(Moves,	Board, Player, Simple, Answer),
	sort(Answer, _L),
	reverse(_L,[NumMax-_Move|_Rest]),
	%write([NumMax-_Move|_Rest]),nl,
	%write(NumMax),nl,nl,
	getBestMoves([NumMax-_Move|_Rest],_BestMoves,NumMax),
	%write(_BestMoves),nl,
	random_member(Move, _BestMoves).

/*Prenche array de moves*/
getBestMoves([], [], _Num).
getBestMoves([Num-Move|Rest], Moves, NumMax):-
	ite(Num = NumMax,
		(getBestMoves(Rest, Mov, NumMax),
			Moves = [Move|Mov]),
		Moves = []).

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
