:- dynamic maxSteps/1,
           capturesList/1.

canManCapture(CurrBoard, Player, X-Y, Direction, NewX-NewY) :-
  ite(Player = 1,
    (
      findPiece(CurrBoard, X-Y, Player),
      ite(Direction = left,
        (
          X1 is X - 1, findPiece(CurrBoard, X1-Y, 2),
          X2 is X - 2, findPiece(CurrBoard, X2-Y, 0),
          NewX is X2, NewY is Y,
        ),
        ite(Direction = right,
          (
           X1 is X + 1, findPiece(CurrBoard, X1-Y, 2),
           X2 is X + 2, findPiece(CurrBoard, X2-Y, 0),
           NewX is X2, NewY is Y,
          ),
          ite(Direction = front,
            (
             Y1 is Y + 1, findPiece(CurrBoard, X-Y1, 2),
             Y2 is Y + 2, findPiece(CurrBoard, X-Y2, 0),
             NewX is X, NewY is Y2,
            ),
            fail
          )
        )
      )
    ),
    (
      findPiece(CurrBoard, X-Y, Player),
      ite(Direction = left,
        (
          X1 is X - 1, findPiece(CurrBoard, X1-Y, 1),
          X2 is X - 2, findPiece(CurrBoard, X2-Y, 0),
          NewX is X2, NewY is Y,
        ),
        ite(Direction = right,
          (
           X1 is X + 1, findPiece(CurrBoard, X1-Y, 1),
           X2 is X + 2, findPiece(CurrBoard, X2-Y, 0),
           NewX is X2, NewY is Y,
          ),
          ite(Direction = front,
            (
             Y1 is Y - 1, findPiece(CurrBoard, X-Y1, 1),
             Y2 is Y - 2, findPiece(CurrBoard, X-Y2, 0),
             NewX is X, NewY is Y2,
            ),
            fail
          )
        )
      )
    )
  ).


getCapturesList(CurrBoard, X-Y, Player, Paths, NCaptures) :-
  member(X, [1, 2, 3, 4, 5, 6, 7, 8]),
  member(Y, [1, 2, 3, 4, 5, 6, 7, 8]),
  assert(maxSteps(0)),
  assert(capturesList([])),
  findCapturesPaths(CurrBoard, X-Y, Player, [X-Y], 0),
  retract(capturesList(Paths)), retract(maxSteps(NCaptures)).

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

  ite((maxSteps(Max), N = Max), (retract(capturesList(L)), append(L, [Path], PathToSave), assert(capturesList(PathToSave))), true),
  ite((maxSteps(Max), N > Max), (retract(capturesList(_)), assert(capturesList([Path])), retract(maxSteps(_)), assert(maxSteps(N))), true).
