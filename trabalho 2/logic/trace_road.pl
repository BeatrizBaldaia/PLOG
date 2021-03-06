:- use_module(library(clpfd)).
:- use_module(library(lists)).

:-include('calculate_values.pl').
:-include('create_board.pl').
:-include('intersection_constraint.pl').
:-include('marked_positions_constraint.pl').
:-include('matrix_parser.pl').
:-include('numbered_positions_neighbors_constraint.pl').
:-include('print.pl').
:-include('simple_separated_roads_constraint.pl').
:-include('test_result.pl').
:-include('statistic.pl').

ite(If, Then, _):- If,!,Then.
ite(_,_,Else):- Else.

%funcao principal
calculate_road(Board-Zeros, Dim, Answer) :-
  length(Answer, Dim),
  createBoard(Answer, Dim),
  append(Answer, Res),%Res é uma lista com todos os elementos da matriz Answer
  checkNumberedPositions(Board,Res,Dim),
  checkZeroPositions(Zeros,Res,Dim),
  checkIntersectedRoads(Res, Dim),
  checkSimpleSeparatedRoads(Answer),
  reset_timer,
  labeling([leftmost,bisect], Res),
  print_time,
  fd_statistics.



%funcao principal com teste apos labeling
calculate_road_testing(Board-Zeros, Dim, Answer) :-
  length(Answer, Dim),
  createBoard(Answer, Dim),
  append(Answer, Res),%Res é uma lista com todos os elementos da matriz Answer
  checkNumberedPositions(Board,Res,Dim),
  checkZeroPositions(Zeros,Res,Dim),
  checkIntersectedRoads(Res, Dim),
  checkSimpleSeparatedRoads(Answer),
  reset_timer,
  labeling([], Res),
  uniqueRoad(Res, Dim),
  print_time,
  fd_statistics.


%['trace_road.pl'],calculate_road([2-2-5,5-2-5,3-3-3,2-5-3,6-6-2]-[],6,RES),showBoard(RES, [2-2-5,5-2-5,3-3-3,2-5-3,6-6-2]-[],6).
%['trace_road.pl'],calculate_road([2-2-5,5-2-5,3-3-3,2-5-3]-[],6,RES),showBoard(RES, [2-2-5,5-2-5,3-3-3,2-5-3]-[],6).


%['trace_road.pl'],calculate_road([2-4-5,3-3-4,3-7-4,3-10-4,4-2-4,5-5-4,5-12-4,6-8-5,8-6-4,9-2-4,9-9-4,10-3-3,11-4-5,11-7-3,11-11-4]-[4-6,4-11,7-7,10-8,10-12,12-10],13,RES),showBoard(RES,[2-4-5,3-3-4,3-7-4,3-10-4,4-2-4,5-5-4,5-12-4,6-8-5,8-6-4,9-2-4,9-9-4,10-3-3,11-4-5,11-7-3,11-11-4]-[4-6,4-11,7-7,10-8,10-12,12-10],13).
