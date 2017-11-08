:- dynamic maxSteps/1,
           capturesList/1.

canManCapture(CurrBoard, Player, X-Y, Direction, NewX-NewY, AdversaryMan, AdversaryKing) :-
  findPiece(CurrBoard, X-Y, Player),
  ite(Direction = left,
    (
      X1 is X - 1, findPiece(CurrBoard, X1-Y, Pl),
      member(Pl, [AdversaryMan, AdversaryKing]),
      X2 is X - 2, findPiece(CurrBoard, X2-Y, 0),
      NewX is X2, NewY is Y
    ),
    (
      ite(Direction = right,
        (
          X1 is X + 1, findPiece(CurrBoard, X1-Y, Pr),
          member(Pr, [AdversaryMan, AdversaryKing]),
          X2 is X + 2, findPiece(CurrBoard, X2-Y, 0),
          NewX is X2, NewY is Y
        ),
        (
          ite(Direction = back,
            (
             Y1 is Y + 1, findPiece(CurrBoard, X-Y1, Pb),
             member(Pb, [AdversaryMan, AdversaryKing]),
             Y2 is Y + 2, findPiece(CurrBoard, X-Y2, 0),
             NewX is X, NewY is Y2
            ),
            (
            ite(Direction = front,
              (
               Y1 is Y - 1, findPiece(CurrBoard, X-Y1, Pf),
               member(Pf, [AdversaryMan, AdversaryKing]),
               Y2 is Y - 2, findPiece(CurrBoard, X-Y2, 0),
               NewX is X, NewY is Y2
              ),
              fail
            ))
        ))
    ))
).

canKingCapture(CurrBoard, AuxBoard, Player, X-Y, Direction, NewX-NewY, AdversaryMan, AdversaryKing) :-
  ite(Player = 1, findPiece(CurrBoard, X-Y, 11), findPiece(CurrBoard, X-Y, 22)),
      write('passou no findPiece'), nl,
      write('Direction = '), write(Direction), nl,
      write('Adversaries: '), write(AdversaryMan), write(', '), write(AdversaryKing), nl,
      ite(Direction = left,
      (%CAN CAPTURE LEFT???
      X1 is X - 1, findPiece(CurrBoard, X1-Y, P),
      write('P = '), write(P), nl,
      ite(member(P, [AdversaryMan, AdversaryKing]),
      (
        write('tem oponente adjacente'), nl,
        X2 is X - 2, findPiece(CurrBoard, X2-Y, 0),
        NewX is X2, NewY is Y,
        AuxBoard =  CurrBoard
      ),
        ite(P = 0,%PODE MOVER EM RETA
          (
          write('vai andar uma casa para a ESQUERDA'), nl,
          updateBoardSimpleMove(CurrBoard, NewBoard, X-Y, X1-Y, Player),
          canKingCapture(NewBoard, AuxBoard, Player, X1-Y, Direction, NewX-NewY, AdversaryMan, AdversaryKing)
          ),
          fail
      ))
      ),%END CAN CAPTURE LEFT
      (
      ite(Direction = right,
      (%CAN CAPTURE RIGHT???
      X1 is X + 1, findPiece(CurrBoard, X1-Y, P2),
      write('P = '), write(P2), nl,
      ite(member(P2, [AdversaryMan, AdversaryKing]),
      (
        write('tem oponente adjacente'), nl,
        X2 is X + 2, findPiece(CurrBoard, X2-Y, 0),
        NewX is X2, NewY is Y,
        AuxBoard =  CurrBoard
      ),
        ite(P2 = 0,%PODE MOVER EM RETA
        (
          write('vai andar uma casa para a DIREITA'), nl,
          updateBoardSimpleMove(CurrBoard, NewBoard2, X-Y, X1-Y, Player),
          canKingCapture(NewBoard2, AuxBoard, Player, X1-Y, Direction, NewX-NewY, AdversaryMan, AdversaryKing)
          ),
          fail
        ))
      ),%END CAN CAPTURE RIGHT
      (
      ite(Direction = back,
      (%CAN CAPTURE BACK???
        Y1 is Y + 1, findPiece(CurrBoard, X-Y1, P3),
        write('P = '), write(P3), nl,
        ite(member(P3, [AdversaryMan, AdversaryKing]),
        (
          write('tem oponente adjacente'), nl,
          Y2 is Y + 2, findPiece(CurrBoard, X-Y2, 0),
          NewX is X, NewY is Y2,
          AuxBoard =  CurrBoard
        ),
        ite(P3 = 0,%PODE MOVER EM RETA
        (
          write('vai andar uma casa pra TRAS'), nl,
          updateBoardSimpleMove(CurrBoard, NewBoard3, X-Y, X-Y1, Player),
          canKingCapture(NewBoard3, AuxBoard, Player, X-Y1, Direction, NewX-NewY, AdversaryMan, AdversaryKing)
        ),
          fail
        ))
      ),%END CAN CAPTURE BACK
      (
      ite(Direction = front,
        (%CAN CAPTURE FRONT???
          Y1 is Y - 1, findPiece(CurrBoard, X-Y1, P4),
          write('P = '), write(P4), nl,
          ite(member(P4, [AdversaryMan, AdversaryKing]),
          (
            write('tem oponente adjacente'), nl,
            Y2 is Y - 2, findPiece(CurrBoard, X-Y2, 0),
            NewX is X, NewY is Y2,
            AuxBoard =  CurrBoard
          ),
          ite(P4 = 0,%PODE MOVER EM RETA
          (
            write('vai andar uma casa para FRENTE'), nl,
            updateBoardSimpleMove(CurrBoard, NewBoard4, X-Y, X-Y1, Player),
            canKingCapture(NewBoard4, AuxBoard, Player, X-Y1, Direction, NewX-NewY, AdversaryMan, AdversaryKing)
          ),
            fail
          ))
        ),%END CAN CAPTURE FRONT
          fail)
      )
      ))
      ))
    ).


getCapturesList(CurrBoard, X-Y, Player, Paths, NCaptures) :-
  member(X, [1, 2, 3, 4, 5, 6, 7, 8]),
  member(Y, [1, 2, 3, 4, 5, 6, 7, 8]),
  assert(maxSteps(0)),
  assert(capturesList([])),
  findManCapturesPaths(CurrBoard, X-Y, Player, [X-Y], 0),
  findKingCapturesPaths(CurrBoard, X-Y, Player, [X-Y], 0),
  retract(capturesList(Paths)), retract(maxSteps(NCaptures)).

findManCapturesPaths(CurrBoard, X-Y, Player, Path, N) :-
  ite(ite(Player = 1, canManCapture(CurrBoard, Player, X-Y, left, NewX-NewY, 2, 22), canManCapture(CurrBoard, Player, X-Y, left, NewX-NewY, 1, 11)),
    (N1 is N + 1,
    updateBoardCaptureMove(CurrBoard, NewBoard, X-Y, NewX-NewY, Player),
    append(Path, [NewX-NewY], NextStep),
    findManCapturesPaths(NewBoard, NewX-NewY, Player, NextStep, N1)),
    true),
  ite(ite(Player = 1, canManCapture(CurrBoard, Player, X-Y, right, NewX2-NewY2, 2, 22), canManCapture(CurrBoard, Player, X-Y, right, NewX2-NewY2, 1, 11)),
    (N2 is N + 1,
    updateBoardCaptureMove(CurrBoard, NewBoard2, X-Y, NewX2-NewY2, Player),
    append(Path, [NewX2-NewY2], NextStep2),
    findManCapturesPaths(NewBoard2, NewX2-NewY2, Player, NextStep2, N2)),
    true),
  ite(ite(Player = 1, canManCapture(CurrBoard, Player, X-Y, back, NewX3-NewY3, 2, 22), canManCapture(CurrBoard, Player, X-Y, back, NewX3-NewY3, 1, 11)),
    (N3 is N + 1,
    updateBoardCaptureMove(CurrBoard, NewBoard3, X-Y, NewX3-NewY3, Player),
    append(Path, [NewX3-NewY3], NextStep3),
    findManCapturesPaths(NewBoard3, NewX3-NewY3, Player, NextStep3, N3)),
    true),
  ite(ite(Player = 1, canManCapture(CurrBoard, Player, X-Y, front, NewX4-NewY4, 2, 22), canManCapture(CurrBoard, Player, X-Y, front, NewX4-NewY4, 1, 11)),
    (N4 is N + 1,
    updateBoardCaptureMove(CurrBoard, NewBoard4, X-Y, NewX4-NewY4, Player),
    append(Path, [NewX4-NewY4], NextStep4),
    findManCapturesPaths(NewBoard4, NewX4-NewY4, Player, NextStep4, N4)),
    true),


  ite((maxSteps(Max), N = Max), (retract(capturesList(L)), append(L, [Path], PathToSave), assert(capturesList(PathToSave))), true),
  ite((maxSteps(Max), N > Max), (retract(capturesList(_)), assert(capturesList([Path])), retract(maxSteps(_)), assert(maxSteps(N))), true).

  findKingCapturesPaths(CurrBoard, X-Y, Player, Path, N) :-
    write('no findKingCapturesPaths com X-Y = '), write(X-Y), nl,
    write('player '), write(Player), nl, nl,
    ite(Player = 1, King is 11, King is 22),
    ite(ite(Player = 1, canKingCapture(CurrBoard, AuxBoard, Player, X-Y, left, NewX-NewY, 2, 22), canKingCapture(CurrBoard, AuxBoard, Player, X-Y, left, NewX-NewY, 1, 11)),
      (N1 is N + 1,
      Xaux is NewX + 2,
      write('consegue capturar para a esquerda'), nl,
      updateBoardCaptureMove(AuxBoard, NewBoard, Xaux-Y, NewX-NewY, King),
      append(Path, [NewX-NewY], NextStep),
      findKingCapturesPaths(NewBoard, NewX-NewY, Player, NextStep, N1)),
      true),
    ite(ite(Player = 1, canKingCapture(CurrBoard, AuxBoard, Player, X-Y, right, NewX2-NewY2, 2, 22), canKingCapture(CurrBoard, AuxBoard, Player, X-Y, right, NewX2-NewY2, 1, 11)),
      (N2 is N + 1,
      write('consegue capturar para a direita'), nl,
      Xaux is NewX2 - 2,
      updateBoardCaptureMove(AuxBoard, NewBoard2, Xaux-Y, NewX2-NewY2, King),
      append(Path, [NewX2-NewY2], NextStep2),
      findKingCapturesPaths(NewBoard2, NewX2-NewY2, Player, NextStep2, N2)),
      true),
    ite(ite(Player = 1, canKingCapture(CurrBoard, AuxBoard, Player, X-Y, back, NewX3-NewY3, 2, 22), canKingCapture(CurrBoard, AuxBoard, Player, X-Y, back, NewX3-NewY3, 1, 11)),
      (N3 is N + 1,
      write('consegue capturar para tras'), nl,
      Yaux is NewY3 - 2,
      updateBoardCaptureMove(AuxBoard, NewBoard3, X-Yaux, NewX3-NewY3, King),
      append(Path, [NewX3-NewY3], NextStep3),
      findKingCapturesPaths(NewBoard3, NewX3-NewY3, Player, NextStep3, N3)),
      true),
    ite(ite(Player = 1, canKingCapture(CurrBoard, AuxBoard, Player, X-Y, front, NewX4-NewY4, 2, 22), canKingCapture(CurrBoard, AuxBoard, Player, X-Y, front, NewX4-NewY4, 1, 11)),
      (N4 is N + 1,
      write('consegue capturar para frente'), nl,
      Yaux is NewY4 + 2,
      updateBoardCaptureMove(AuxBoard, NewBoard4, X-Yaux, NewX4-NewY4, King),
      write('OCOREU UPDATE!'),
      append(Path, [NewX4-NewY4], NextStep4),
      findKingCapturesPaths(NewBoard4, NewX4-NewY4, Player, NextStep4, N4)),
      true),

    ite((maxSteps(Max), N = Max), (retract(capturesList(L)), append(L, [Path], PathToSave), assert(capturesList(PathToSave))), true),
    ite((maxSteps(Max), N > Max), (retract(capturesList(_)), assert(capturesList([Path])), retract(maxSteps(_)), assert(maxSteps(N))), true).
