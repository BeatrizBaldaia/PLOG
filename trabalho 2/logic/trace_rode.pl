:- use_module(library(clpfd)).
:- use_module(library(lists)).

ite(If, Then, _):- If,!,Then.
ite(_,_,Else):- Else.

%funcao principal
calculate_road(Board, Dim, Answer) :-
  length(Answer, Dim),
  createBoard(Answer, Dim),
  append(Answer, Res),%Res é uma lista com todos os elementos da matriz Answer
  checkNumberedPositions(Board,Res,Dim),
  checkIntersectedRoads(Res, Dim),
  labeling([], Res).

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
  ((Elem #= 1 #/\ ValueDownRight #= 1) #=> (ValueRight #= 1 #\ ValueDownLeft #= 1)),
  ((Elem #= 0 #/\ ValueDownRight #= 0) #=> (ValueRight #= 0 #\/ ValueDownLeft #= 0)),
  X1 is X + 1,
  checkNextColumn(Res, Dim, Y, X1).

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



%calculate_road([2-2-5,5-2-5,3-3-3,2-5-3,6-6-2],6,RES),showBoard(RES).
%calculate_road([2-2-5,5-2-5,3-3-3,2-5-3],6,RES),showBoard(RES).


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
