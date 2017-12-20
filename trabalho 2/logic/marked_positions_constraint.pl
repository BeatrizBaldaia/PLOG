%as posicoes que ja estao inicialmente marcadas a preto
%no mapa, nao podem fazer parte do caminho calculado
checkZeroPositions([], _, _).
checkZeroPositions([H|R], QueueBoard, Dim):-
  checkZero(H, QueueBoard, Dim),
  checkZeroPositions(R, QueueBoard, Dim).
checkZero(X-Y, QueueBoard, Dim):-
    Pos #= (Y-1) * Dim + X,%posicao correspondente na QueueBoard
    element(Pos, QueueBoard, 0).
