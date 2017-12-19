:- use_module(library(clpfd)).
:- use_module(library(lists)).

ite(If, Then, _):- If,!,Then.
ite(_,_,Else):- Else.

%funcao principal
calculate_road(Board-Zeros, Dim, Answer) :-
  length(Answer, Dim),
  createBoard(Answer, Dim),
  write('criour board'), nl,
  append(Answer, Res),%Res é uma lista com todos os elementos da matriz Answer
  write('fez append'), nl,
  checkNumberedPositions(Board,Res,Dim),
  checkZeroPositions(Zeros,Res,Dim),
  write('verificou casas adjacentes as numeradas'), nl,
  checkIntersectedRoads(Res, Dim),
  write('verificou caminhos intersetados'), nl,
  checkOneRoad(Res, Dim, AuxBoard),
  write('verificou um caminho'), nl,
  %write(AuxBoard),
  labeling([], Res),
  %write(AuxBoard),nl,nl,
  %showBoard(Answer),
  teste(AuxBoard).
  %nl,  write(AuxBoard).

teste(AuxBoard):- !,
  nth1(Pos, AuxBoard, 3),!,
  ground(AuxBoard).
checkOneRoad(Res, Dim, Board):-
  BoardDimention is Dim * Dim,
  length(Board, BoardDimention),
  %domain(Board, 0, 3),
  paint(Board, Res, Dim).
paint(Board, Res, Dim):-
  paintRoad(Board, Res, Dim, 1),
  paintLines(Board, Res, Dim, 1),
  paintBetween(Board, Res, Dim, 1).

paintBetween(Board, Res, Dim, Line):- Line is Dim + 1.
paintBetween(Board, Res, Dim, Line):-
  paintBetweenColumns(Board, Res, Dim, Line, 1),
  NextLine is Line + 1,
  paintBetween(Board, Res, Dim, NextLine).

paintBetweenColumns(Board, Res, Dim, Line, Column):- Column is Dim + 1.
paintBetweenColumns(Board, Res, Dim, Line, Column):-
  Pos #= (Line-1) * Dim + Column,
  Left #= Pos - 1,
  Right #= Pos + 1,
  Up #= (Line-2) * Dim + Column,
  UpLeft #= Up - 1,
  UpRight #= Up + 1,
  Down #= (Line) * Dim + Column,
  DownLeft #= Down - 1,
  DownRight #= Down + 1,
  element(Pos, Res, Elem),
  element(Pos, Board, Paint),
  ite(Column = 1, PaintValueLeft = 0, element(Left, Board, PaintValueLeft)),
  ite(Column = Dim, PaintValueRight = 0, element(Right, Board, PaintValueRight)),
  ite(Line = 1,
    (PaintValueUpLeft = 0, PaintValueUp = 0, PaintValueUpRight = 0),
    (element(Up, Board, PaintValueUp),
      ite(Column = 1, PaintValueUpLeft = 0, element(UpLeft, Board, PaintValueUpLeft)),
      ite(Column = Dim, PaintValueUpRight = 0, element(UpRight, Board, PaintValueUpRight)))),
  ite(Line = Dim,
    (PaintValueDownLeft = 0, PaintValueDown = 0, PaintValueDownRight = 0),
    (element(Down, Board, PaintValueDown),
       ite(Column = 1, PaintValueDownLeft = 0, element(DownLeft, Board, PaintValueDownLeft)),
       ite(Column = Dim, PaintValueDownRight = 0, element(DownRight, Board, PaintValueDownRight)))),

  (((Elem #= 0) #/\ (#\((PaintValueLeft #= 2) #\/ (PaintValueRight #= 2)
    #\/ (PaintValueUpLeft #= 2) #\/ (PaintValueUp #= 2) #\/ (PaintValueUpRight #= 2)
    #\/ (PaintValueDownLeft #= 2) #\/ (PaintValueDown #= 2) #\/ (PaintValueDownRight #= 2)))
    #/\ (#\((PaintValueLeft #= 0) #\/ (PaintValueRight #= 0) #\/ (PaintValueUpLeft #= 0)
    #\/ (PaintValueUp #= 0) #\/ (PaintValueUpRight #= 0) #\/ (PaintValueDownLeft #= 0)
    #\/ (PaintValueDown #= 0) #\/ (PaintValueDownRight #= 0)))) #=> (Paint #= 3)),
  %(Elem #= 1) => (Paint#=
  NextColumn is Column + 1,
  paintBetweenColumns(Board, Res, Dim, Line, NextColumn).

paintLines(Board, Res, Dim, Line):- Line is Dim + 1.
paintLines(Board, Res, Dim, Line):-
  paintLinesColumns(Board, Res, Dim, Line, 1),
  NextLine is Line + 1,
  paintLines(Board, Res, Dim, NextLine).

paintLinesColumns(Board, Res, Dim, Line, Column):- Column is Dim + 1.
paintLinesColumns(Board, Res, Dim, Line, Column):-
  Pos #= (Line-1) * Dim + Column,
  Left #= Pos - 1,
  Right #= Pos + 1,
  Up #= (Line-2) * Dim + Column,
  UpLeft #= Up - 1,
  UpRight #= Up + 1,
  Down #= (Line) * Dim + Column,
  DownLeft #= Down - 1,
  DownRight #= Down + 1,
  element(Pos, Res, Elem),
  element(Pos, Board, Paint),
  ite(Column = 1, ValueLeft = 0, element(Left, Board, ValueLeft)),
  ite(Column = Dim, ValueRight = 0, element(Right, Board, ValueRight)),
  ite(Line = 1,
    (ValueUpLeft = 0, ValueUp = 0, ValueUpRight = 0),
    (element(Up, Board, ValueUp),
      ite(Column = 1, ValueUpLeft = 0, element(UpLeft, Board, ValueUpLeft)),
      ite(Column = Dim, ValueUpRight = 0, element(UpRight, Board, ValueUpRight)))),
  ite(Line = Dim,
    (ValueDownLeft = 0, ValueDown = 0, ValueDownRight = 0),
    (element(Down, Board, ValueDown),
       ite(Column = 1, ValueDownLeft = 0, element(DownLeft, Board, ValueDownLeft)),
       ite(Column = Dim, ValueDownRight = 0, element(DownRight, Board, ValueDownRight)))),
  ((Elem #= 1) #=> (Paint #= 1)),
  (((Elem #= 0) #/\ ((ValueLeft #= 0) #\/ (ValueRight #= 0) #\/ (ValueUpLeft #= 0) #\/ (ValueUp #= 0) #\/ (ValueUpRight #= 0) #\/ (ValueDownLeft #= 0) #\/ (ValueDown #= 0) #\/ (ValueDownRight #= 0))) #=> (Paint #= 2)),
  (((Elem #= 0) #/\ ((ValueLeft #= 2) #\/ (ValueRight #= 2) #\/ (ValueUpLeft #= 2) #\/ (ValueUp #= 2) #\/ (ValueUpRight #= 2) #\/ (ValueDownLeft #= 2) #\/ (ValueDown #= 2) #\/ (ValueDownRight #= 2))) #=> (Paint #= 2)),
  %(((Elem #= 0) #/\ ((ValueLeft #= 0) #\/ (ValueRight #= 0) #\/ (ValueUpLeft #= 0) #\/ (ValueUp #= 0) #\/ (ValueUpRight #= 0) #\/ (ValueDownLeft #= 0) #\/ (ValueDown #= 0) #\/ (ValueDownRight #= 0))) #=> (Paint #= 0)),%TODO ver
  NextColumn is Column + 1,
  paintLinesColumns(Board, Res, Dim, Line, NextColumn).

paintRoad(_,_, Dim, Pos):- Pos is Dim*Dim + 1.
paintRoad(Board, Res, Dim, Pos):-
  element(Pos, Res, Elem),
  element(Pos, Board, Paint),
  ((Elem #= 1) #=> (Paint #= 1)),
  NextPos is Pos + 1,
  paintRoad(Board, Res, Dim, NextPos).
% Cria uma matriz Dim x Dim
createBoard([H],Dim):-
  length(H, Dim),
  domain(H,0,1).
createBoard([H|Answer], Dim):-
  length(H, Dim),
  domain(H,0,1),
  createBoard(Answer, Dim).

%verifica se nao ha dois caminhos distintos com um vertice e comum
checkIntersectedRoads(Res, Dim):-
	checkNextRow(Res, Dim, 1).

checkNextRow(_, Dim, Y):- Dim + 1 =:= Y.
checkNextRow(Res, Dim, Y):-
	checkNextColumn(Res, Dim, Y, 1),
	Y1 is Y + 1,
	checkNextRow(Res, Dim, Y1).

checkNextColumn(_, Dim,_, X):- Dim + 1 =:= X. %chegou ao fim da linha
checkNextColumn(Res, Dim, Y, X):-
  Pos #= (Y-1) * Dim + X,
  Left #= Pos - 1,
  Right #= Pos + 1,
  Up #= (Y-2) * Dim + X,
  UpLeft #= Up - 1,
  UpRight #= Up + 1,
  Down #= (Y) * Dim + X,
  DownLeft #= Down - 1,
  DownRight #= Down + 1,
  element(Pos, Res, Elem),

  ite(X = 1, ValueLeft = 0, element(Left, Res, ValueLeft)),

  ite(X = Dim, ValueRight = 0, element(Right, Res, ValueRight)),

  ite(Y = 1,
    (ValueUpLeft = 0, ValueUp = 0, ValueUpRight = 0),
	  (element(Up, Res, ValueUp),
      ite(X = 1, ValueUpLeft = 0, element(UpLeft, Res, ValueUpLeft)),
      ite(X = Dim, ValueUpRight = 0, element(UpRight, Res, ValueUpRight)))),

  ite(Y = Dim,
    (ValueDownLeft = 0, ValueDown = 0, ValueDownRight = 0),
	  (element(Down, Res, ValueDown),
	     ite(X = 1, ValueDownLeft = 0, element(DownLeft, Res, ValueDownLeft)),
       ite(X = Dim, ValueDownRight = 0, element(DownRight, Res, ValueDownRight)))),

  VSides #= ValueLeft + ValueRight + ValueUp + ValueDown,
  VDiagonal #= ValueUpLeft + ValueUpRight + ValueDownLeft + ValueDownRight,
  %((Elem #= 1 #/\ VSides #= 2 #/\ VDiagonal #= 0)#\/ (Elem #= 0)),
  ((Elem #= 1 #/\ VSides #= 2)#\/ (Elem #= 0)),
  ((Elem #= 1 #/\ ValueDownRight #= 1) #=> (ValueRight #= 1 #\ ValueDown #= 1)),
  ((Elem #= 0 #/\ ValueDownRight #= 0) #=> (ValueRight #= 0 #\/ ValueDown #= 0)),
  X1 is X + 1,
  checkNextColumn(Res, Dim, Y, X1).

checkZeroPositions([], _, _).
checkZeroPositions([H|R], QueueBoard, Dim):-
  checkZero(H, QueueBoard, Dim),
  checkZeroPositions(R, QueueBoard, Dim).
checkZero(X-Y, QueueBoard, Dim):-
    Pos #= (Y-1) * Dim + X,%posicao correspondente na QueueBoard
    element(Pos, QueueBoard, 0).

%verifica se os arredores de uma posicao numerada tem o numero certo de casas pintadas
checkNumberedPositions([], _, _).
checkNumberedPositions([H|R], QueueBoard, Dim):-
  checkAdjacentValues(H, QueueBoard, Dim),
  checkNumberedPositions(R, QueueBoard, Dim).


checkAdjacentValues(X-Y-V, QueueBoard, Dim):-
  Pos #= (Y-1) * Dim + X,%posicao correspondente na QueueBoard
  Left #= Pos - 1,
  Right #= Pos + 1,
  Up #= (Y-2) * Dim + X,
  UpLeft #= Up - 1,
  UpRight #= Up + 1,
  Down #= (Y) * Dim + X,
  DownLeft #= Down - 1,
  DownRight #= Down + 1,

  element(Pos, QueueBoard, 0),
  ite(X = 1, ValueLeft = 0, element(Left, QueueBoard, ValueLeft)),
  ite(X = Dim, ValueRight = 0, element(Right, QueueBoard, ValueRight)),

  ite(Y = 1, (ValueUpLeft = 0, ValueUp = 0, ValueUpRight = 0),
    (element(Up, QueueBoard, ValueUp),
    ite(X = 1, ValueUpLeft = 0, element(UpLeft, QueueBoard, ValueUpLeft)),
      ite(X = Dim, ValueUpRight = 0, element(UpRight, QueueBoard, ValueUpRight)))),

  ite(Y = Dim, (ValueDownLeft = 0, ValueDown = 0, ValueDownRight = 0),
    (element(Down, QueueBoard, ValueDown),
    ite(X = 1, ValueDownLeft = 0, element(DownLeft, QueueBoard, ValueDownLeft)),
      ite(X = Dim, ValueDownRight = 0, element(DownRight, QueueBoard, ValueDownRight)))),

  V #= ValueUpLeft + ValueUp + ValueUpRight + ValueLeft + ValueRight + ValueDownLeft + ValueDown + ValueDownRight.

%['trace_rode.pl'],calculate_road([2-2-5,5-2-5,3-3-3,2-5-3,6-6-2]-[],6,RES),showBoard(RES).
%['trace_rode.pl'],calculate_road([2-2-5,5-2-5,3-3-3,2-5-3]-[],6,RES),showBoard(RES).


%['trace_rode.pl'],calculate_road([2-4-5,3-3-4,3-7-4,3-10-4,4-2-4,5-5-4,5-12-4,6-8-5,8-6-4,9-2-4,9-9-4,10-3-3,11-4-5,11-7-3,11-11-4]-[4-6,4-11,7-7,10-8,10-12,12-10],13,RES),showBoard(RES).


/*Predicado Para Mostrar o Tabuleiro*/
showBoard(X):- !,nl,showRow(X, 1).
showRow(X, Y):- X = [],!.
showRow(X, Y):- !,X = [H|R],
	Yn is (Y + 1),
	write('--------------------------------------------------------------------------------------------'), nl,
	showRowValues(H), nl,
	showRow(R, Yn).
showRowValues(X):- X = [] ,!, write(' |').
showRowValues(X):- !,X = [H|R],
	write(' | '),
	showPiece(H),
	showRowValues(R).
showPiece(X):- X = 1,!,
	put_code(219).
showPiece(X):- X = 0,!,
	write(' ').
showPiece(X):- !,X = 2,
  	put_code(65).
%showPiece(X):- put_code(66).
