:- use_module(library(clpfd)).
:- use_module(library(lists)).

calculate_road(Board, Dim, Answer) :-
  length(Answer, Dim),
  createBoard(Answer, Dim),
  append(Answer, Res),
  createConstrain(Board,Res,Dim),
  labeling([], Res).

createBoard([H],Dim):-
  length(H, Dim),
  domain(H,0,1).
createBoard([H|Answer], Dim):-
  length(H, Dim),
  domain(H,0,1),
  createBoard(Answer, Dim).

createConstrain([], _, _).
createConstrain([H|R], ListofLists, Dim):-
  minesweeper(H, ListofLists, Dim),
  createConstrain(R, ListofLists, Dim).

minesweeper(X-Y-V, ListofLists, Dim):-
  write('Aqh'),
  Pos #= (Y-1) * Dim + X,
  write('assdfa'),
  PosMinus #= Pos - 1,
  PosMinus #= Pos + 1,
  element(Pos, ListofLists, 0),
   write('asssrfsdrfsdrfgsdfsdfsdfg'),nl,
  element(PosMinus, ListofLists, V1),
  element(PosPlus, ListofLists, V2),
  Pos1 #= (Y-2) * Dim + X,
  Pos1Minus #= Pos1 - 1,
  Pos1Minus #= Pos1 + 1,
  element(Pos1, ListofLists, V3),
  element(Pos1Minus, ListofLists, V4),
  element(Pos1Plus, ListofLists, V5),
  Pos2 #= (Y) * Dim + X,
  Pos2Minus #= Pos2 - 1,
  Pos2Minus #= Pos2 + 1,
  element(Pos2, ListofLists, V6),
  element(Pos2Minus, ListofLists, V7),
  element(Pos2Plus, ListofLists, V8),
  V #= V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8.
  
%calculate_road([2-2-5,5-2-5,3-3-3,2-5-3,6-6-2],6,RES).
%calculate_road([2-2-5,5-2-5,3-3-3,2-5-3],6,RES).
