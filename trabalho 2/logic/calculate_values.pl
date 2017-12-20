getBoardValues(X, Y, Res, Dim, Elem, Pos, ValueUpLeft, ValueUp, ValueUpRight, ValueLeft, ValueRight, ValueDownLeft, ValueDown, ValueDownRight) :-
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
       ite(X = Dim, ValueDownRight = 0, element(DownRight, Res, ValueDownRight)))).
