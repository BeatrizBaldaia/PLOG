%verifica se os arredores de uma posicao numerada tem o numero certo de casas pintadas
checkNumberedPositions([], _, _).
checkNumberedPositions([H|R], QueueBoard, Dim):-
  checkAdjacentValues(H, QueueBoard, Dim),
  checkNumberedPositions(R, QueueBoard, Dim).


checkAdjacentValues(X-Y-V, QueueBoard, Dim):-
  getBoardValues(X, Y, QueueBoard, Dim, Elem, Pos, ValueUpLeft, ValueUp, ValueUpRight, ValueLeft, ValueRight, ValueDownLeft, ValueDown, ValueDownRight),
  Elem #= 0,
  V #= ValueUpLeft + ValueUp + ValueUpRight + ValueLeft + ValueRight + ValueDownLeft + ValueDown + ValueDownRight.
