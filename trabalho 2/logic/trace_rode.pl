:- use_module(library(clpfd)).
:- use_module(library(lists)).

:-include('calculate_values.pl').
:-include('paint_constraint.pl').
:-include('print.pl').
:-include('test_result.pl').

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
  %checkOneRoad(Res, Dim, AuxBoard),
  write('verificou um caminho'), nl,
  %write(AuxBoard),
  labeling([], Res).
  %write(AuxBoard),nl,nl,
  %showBoard(Answer).
  %teste(AuxBoard).
  %nl,  write(AuxBoard).

teste(AuxBoard):- !,
  nth1(Pos, AuxBoard, 3),!,
  ground(AuxBoard).

checkOneRoad(Res, Dim, Board):-
  BoardDimention is Dim * Dim,
  length(Board, BoardDimention),
  %domain(Board, 0, 3),
  paint(Board, Res, Dim).

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
  getBoardValues(X, Y, Res, Dim, Elem, Pos, ValueUpLeft, ValueUp, ValueUpRight, ValueLeft, ValueRight, ValueDownLeft, ValueDown, ValueDownRight),

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
  getBoardValues(X, Y, QueueBoard, Dim, Elem, Pos, ValueUpLeft, ValueUp, ValueUpRight, ValueLeft, ValueRight, ValueDownLeft, ValueDown, ValueDownRight),

  V #= ValueUpLeft + ValueUp + ValueUpRight + ValueLeft + ValueRight + ValueDownLeft + ValueDown + ValueDownRight.

%['trace_rode.pl'],calculate_road([2-2-5,5-2-5,3-3-3,2-5-3,6-6-2]-[],6,RES),showBoard(RES).
%['trace_rode.pl'],calculate_road([2-2-5,5-2-5,3-3-3,2-5-3]-[],6,RES),showBoard(RES).


%['trace_rode.pl'],calculate_road([2-4-5,3-3-4,3-7-4,3-10-4,4-2-4,5-5-4,5-12-4,6-8-5,8-6-4,9-2-4,9-9-4,10-3-3,11-4-5,11-7-3,11-11-4]-[4-6,4-11,7-7,10-8,10-12,12-10],13,RES),showBoard(RES).
