:- dynamic MaxSteps/1.
:- dynamic CapturesList/1.

canManCapture(CurrBoard, Player, X-Y, Direction, NewX-NewY) :-
  (Player = 1) -> (
   (Direction = left) -> (X1 is X - 1, findPiece(CurrBoard, X1-Y, 2),
      X2 is X - 2, findPiece(CurrBoard, X2-Y, 0),
      NewX is X2, NewY is Y;
   (Direction = right) -> (X1 is X + 1, findPiece(CurrBoard, X1-Y, 2),
      X2 is X + 2, findPiece(CurrBoard, X2-Y, 0),
      NewX is X2, NewY is Y;
   (Direction = front) -> (Y1 is Y + 1, findPiece(CurrBoard, X-Y1, 2),
      Y2 is Y + 2, findPiece(CurrBoard, X-Y2, 0),
      NewX is X, NewY is Y2;
  );
  (Player = 2) -> (
    (Direction = left) -> (X1 is X - 1, findPiece(CurrBoard, X1-Y, 1),
       X2 is X - 2, findPiece(CurrBoard, X2-Y, 0),
       NewX is X2, NewY is Y;
    (Direction = right) -> (X1 is X + 1, findPiece(CurrBoard, X1-Y, 1),
       X2 is X + 2, findPiece(CurrBoard, X2-Y, 0),
       NewX is X2, NewY is Y;
    (Direction = front) -> (Y1 is Y - 1, findPiece(CurrBoard, X-Y1, 1),
       Y2 is Y + 2, findPiece(CurrBoard, X-Y2, 0),
       NewX is X, NewY is Y2;
  ).


getCapturesList(CurrBoard, X-Y, Player, Paths, NCaptures) :-
  assert(MaxSteps(0)),
  assert(CapturesList([])),
  findCapturesPaths(CurrBoard, X-Y, Player, [X-Y], 0),
  retract(CapturesList(Paths)), retract(MaxSteps(NCaptures)).

findCapturesPaths(CurrBoard, X-Y, Player, Path, N) :-
  ite(canManCapture(CurrBoard, Player, X-Y, left, NewX-NewY),
    (N1 is N + 1,
    updateBoardCaptureMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
    append(Path, [NewX-NewY], NextStep),
    findCapturesPaths(NewBoard, NewX-NewY, Player, NextStep, N1)),
    true),
  ite(canManCapture(CurrBoard, Player, X-Y, right, NewX2-NewY2),
    (N2 is N + 1,
    updateBoardCaptureMove(CurrBoard, NewBoard2, X-Y, NewX2-NewY2, Player),
    append(Path, [NewX2-NewY2], NextStep2),
    findCapturesPaths(NewBoard2, NewX2-NewY2, Player, NextStep2, N2)),
    true),
  ite(canManCapture(CurrBoard, Player, X-Y, front, NewX3-NewY3),
    (N3 is N + 1,
    updateBoardCaptureMove(CurrBoard, NewBoard3, X-Y, NewX3-NewY3, Player),
    append(Path, [NewX3-NewY3], NextStep3),
    findCapturesPaths(NewBoard3, NewX3-NewY3, Player, NextStep3, N3)),
    true),
  ite((MaxSteps(Max), N = Max), (retract(CapturesList(L)), append(L, [Path], PathToSave), assert(CapturesList(PathToSave))), true),
  ite((MaxSteps(Max), N > Max), (retract(CapturesList(_)), assert(CapturesList(Path)), retract(MaxSteps(_)), assert(MaxSteps(N))), true).
