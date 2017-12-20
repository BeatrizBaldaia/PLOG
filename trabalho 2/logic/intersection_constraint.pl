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
  ((Elem #= 1 #/\ VSides #= 2)#\/ (Elem #= 0)),
  ((Elem #= 1 #/\ ValueDownRight #= 1) #=> (ValueRight #= 1 #\ ValueDown #= 1)),
  ((Elem #= 0 #/\ ValueDownRight #= 0) #=> (ValueRight #= 0 #\/ ValueDown #= 0)),
  X1 is X + 1,
  checkNextColumn(Res, Dim, Y, X1).
