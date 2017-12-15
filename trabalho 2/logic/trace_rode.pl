:- use_module(library(clpfd)).
:- use_module(library(lists)).

calculate_road(Board, Dim, Answer) :-
  length(Answer, Dim),
  createBoard(Answer, Dim),
  append(Answer, Res),
  createConstrain(Board,Res,Dim),
 isClose(Res, Dim),
  labeling([], Res).

isClose(Res, Dim):-
	isCloseY(Res, Dim, 1).
	
isCloseY(_, Dim, Y):- Dim + 1 =:= Y.
isCloseY(Res, Dim, Y):-
	isCloseX(Res, Dim, Y, 1),
	Y1 is Y + 1,
	isCloseY(Res, Dim, Y1).
	
isCloseX(_, Dim,_, X):- Dim + 1 =:= X.
isCloseX(Res, Dim, Y, X):-
  Pos #= (Y-1) * Dim + X,
  PosMinus #= Pos - 1,
  PosPlus #= Pos + 1,
  Pos1 #= (Y-2) * Dim + X,
  Pos1Minus #= Pos1 - 1,
  Pos1Plus #= Pos1 + 1,
  Pos2 #= (Y) * Dim + X,
  Pos2Minus #= Pos2 - 1,
  Pos2Plus #= Pos2 + 1,
  element(Pos, Res, Elem),
  ite(X = 1, V1 = 0, element(PosMinus, Res, V1)),
  ite(X = Dim, V2 = 0, element(PosPlus, Res, V2)),
  ite(Y = 1, (V3 = 0, V4 = 0, V5 = 0), 
	(element(Pos1, Res, V3),
	ite(X = 1, V4 = 0, element(Pos1Minus, Res, V4)),
	ite(X = Dim, V5 = 0, element(Pos1Plus, Res, V5)))),
  ite(Y = Dim, (V6 = 0, V7 = 0, V8 = 0), 
	(element(Pos2, Res, V6),
	ite(X = 1, V7 = 0, element(Pos2Minus, Res, V7)),
	ite(X = Dim, V8 = 0, element(Pos2Plus, Res, V8)))),
  VSides #= V1 + V2 + V3 + V6,
  VDiagonal #= V4 + V5 + V7 + V8,
  %((Elem #= 1 #/\ VSides #= 2 #/\ VDiagonal #= 0)#\/ (Elem #= 0)),
  ((Elem #= 1 #/\ VSides #= 2)#\/ (Elem #= 0)),
  ((Elem #= 1 #/\ V8 #= 1) #=> (V2 #= 1 #\ V6 #= 1)),
  ((Elem #= 0 #/\ V8 #= 0) #=> (V2 #= 0 #\/ V6 #= 0)),
  X1 is X + 1,
  isCloseX(Res, Dim, Y, X1).

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
  Pos #= (Y-1) * Dim + X,
  PosMinus #= Pos - 1,
  PosPlus #= Pos + 1,
  Pos1 #= (Y-2) * Dim + X,
  Pos1Minus #= Pos1 - 1,
  Pos1Plus #= Pos1 + 1,
  Pos2 #= (Y) * Dim + X,
  Pos2Minus #= Pos2 - 1,
  Pos2Plus #= Pos2 + 1,
  
  element(Pos, ListofLists, 0),
  ite(X = 1, V1 = 0, element(PosMinus, ListofLists, V1)),
  ite(X = Dim, V2 = 0, element(PosPlus, ListofLists, V2)),
  
  ite(Y = 1, (V3 = 0, V4 = 0, V5 = 0), 
	(element(Pos1, ListofLists, V3),
	ite(X = 1, V4 = 0, element(Pos1Minus, ListofLists, V4)),
	ite(X = Dim, V5 = 0, element(Pos1Plus, ListofLists, V5)))),
  ite(Y = Dim, (V6 = 0, V7 = 0, V8 = 0), 
	(element(Pos2, ListofLists, V6),
	ite(X = 1, V7 = 0, element(Pos2Minus, ListofLists, V7)),
	ite(X = Dim, V8 = 0, element(Pos2Plus, ListofLists, V8)))),
  V #= V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8.
  
%calculate_road([2-2-5,5-2-5,3-3-3,2-5-3,6-6-2],6,RES),showBoard(RES).
%calculate_road([2-2-5,5-2-5,3-3-3,2-5-3],6,RES),showBoard(RES).
ite(If, Then, _):- If,!,Then.
ite(_,_,Else):- Else.

%calculate_road([2-4-5,3-3-4,3-7-4,3-10-4,4-2-4,5-5-4,5-12-4,6-8-5,8-6-4,9-2-4,9-9-4,10-3-3,11-4-5,11-7-3,11-11-4],13,RES),showBoard(RES).


/*Predicado Para Mostrar o Tabuleiro*/
showBoard(X):- nl,showRow(X, 1).
showRow(X, Y):- X = [].
showRow(X, Y):- X = [H|R],
	Yn is (Y + 1),
	write('--------------------------------------------------------------------------------------------'), nl,
	showRowValues(H), nl,
	showRow(R, Yn).
showRowValues(X):- X = [] , write(' |').
showRowValues(X):- X = [H|R],
	write(' | '),
	showPiece(H),
	showRowValues(R).
showPiece(X):- X = 1,
	put_code(219).
showPiece(X):- X = 0,
	write(' ').
