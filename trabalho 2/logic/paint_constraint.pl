paint(Board, Res, Dim):-
  paintRoad(Board, Res, Dim, 1),
  paintLines(Board, Res, Dim, 1),
  paintBetween(Board, Res, Dim, 1).

paintRoad(_,_, Dim, Pos):- Pos is Dim*Dim + 1.
paintRoad(Board, Res, Dim, Pos):-
  element(Pos, Res, Elem),
  element(Pos, Board, Paint),
  ((Elem #= 1) #=> (Paint #= 1)),
  NextPos is Pos + 1,
  paintRoad(Board, Res, Dim, NextPos).

paintLines(Board, Res, Dim, Line):- Line is Dim + 1.
paintLines(Board, Res, Dim, Line):-
  paintLinesColumns(Board, Res, Dim, Line, 1),
  NextLine is Line + 1,
  paintLines(Board, Res, Dim, NextLine).

paintLinesColumns(Board, Res, Dim, Line, Column):- Column is Dim + 1.
paintLinesColumns(Board, Res, Dim, Line, Column):-
  getBoardValues(Column, Line, Board, Dim, Paint, Pos, ValueUpLeft, ValueUp, ValueUpRight, ValueLeft, ValueRight, ValueDownLeft, ValueDown, ValueDownRight),

  element(Pos, Res, Elem),

  ((Elem #= 1) #=> (Paint #= 1)),
  (((Elem #= 0) #/\ ((ValueLeft #= 0) #\/ (ValueRight #= 0) #\/ (ValueUpLeft #= 0) #\/ (ValueUp #= 0) #\/ (ValueUpRight #= 0) #\/ (ValueDownLeft #= 0) #\/ (ValueDown #= 0) #\/ (ValueDownRight #= 0))) #=> (Paint #= 2)),
  (((Elem #= 0) #/\ ((ValueLeft #= 2) #\/ (ValueRight #= 2) #\/ (ValueUpLeft #= 2) #\/ (ValueUp #= 2) #\/ (ValueUpRight #= 2) #\/ (ValueDownLeft #= 2) #\/ (ValueDown #= 2) #\/ (ValueDownRight #= 2))) #=> (Paint #= 2)),
  %(((Elem #= 0) #/\ ((ValueLeft #= 0) #\/ (ValueRight #= 0) #\/ (ValueUpLeft #= 0) #\/ (ValueUp #= 0) #\/ (ValueUpRight #= 0) #\/ (ValueDownLeft #= 0) #\/ (ValueDown #= 0) #\/ (ValueDownRight #= 0))) #=> (Paint #= 0)),%TODO ver
  NextColumn is Column + 1,
  paintLinesColumns(Board, Res, Dim, Line, NextColumn).

paintBetween(Board, Res, Dim, Line):- Line is Dim + 1.
paintBetween(Board, Res, Dim, Line):-
  paintBetweenColumns(Board, Res, Dim, Line, 1),
  NextLine is Line + 1,
  paintBetween(Board, Res, Dim, NextLine).

paintBetweenColumns(Board, Res, Dim, Line, Column):- Column is Dim + 1.
paintBetweenColumns(Board, Res, Dim, Line, Column):-
  getBoardValues(Column, Line, Board, Dim, Paint, Pos, PaintValueUpLeft, PaintValueUp, PaintValueUpRight, PaintValueLeft, PaintValueRight, PaintValueDownLeft, PaintValueDown, PaintValueDownRight),

  element(Pos, Res, Elem),

  (((Elem #= 0) #/\ (#\((PaintValueLeft #= 2) #\/ (PaintValueRight #= 2)
    #\/ (PaintValueUpLeft #= 2) #\/ (PaintValueUp #= 2) #\/ (PaintValueUpRight #= 2)
    #\/ (PaintValueDownLeft #= 2) #\/ (PaintValueDown #= 2) #\/ (PaintValueDownRight #= 2)))
    #/\ (#\((PaintValueLeft #= 0) #\/ (PaintValueRight #= 0) #\/ (PaintValueUpLeft #= 0)
    #\/ (PaintValueUp #= 0) #\/ (PaintValueUpRight #= 0) #\/ (PaintValueDownLeft #= 0)
    #\/ (PaintValueDown #= 0) #\/ (PaintValueDownRight #= 0)))) #=> (Paint #= 3)),
  %(Elem #= 1) => (Paint#=
  NextColumn is Column + 1,
  paintBetweenColumns(Board, Res, Dim, Line, NextColumn).
