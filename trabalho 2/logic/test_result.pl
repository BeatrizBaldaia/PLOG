:- dynamic pos/1, index/1.

%falha se houver mais do que um caminho fechado
uniqueRoad(BoardQueue, Dim) :-
  retractall(pos(_)),
  retractall(index(_)),
  assert(pos([])),
  assert(index([1])),
  checkResultValues(BoardQueue, Dim, 1),
  hasAdjacent,
  pos(Pos),
  index(I),
  length(Pos, TotalSize),
  length(I, FinalSize),
  write('TotalSize = '), write(TotalSize), nl,
  write('FinalSize = '), write(FinalSize), nl,
  write('------------------------------------'), nl, nl,
  retract(pos(_)),
  retract(index(_)),
  TotalSize = FinalSize.

%percorre o tabuleiro resultante
checkResultValues([], _, _).
checkResultValues([H|T], Dim, It) :-
  AuxX is It mod Dim,
  AuxY is It//Dim,
  ite(AuxX = 0, (X is Dim, Y is AuxY), (X is AuxX, Y is AuxY + 1)),
  NewIt is It + 1,
  savePosition(X, Y, H),
  checkResultValues(T, Dim, NewIt).

%guarda a posicao das casas a preto (do caminho)
savePosition(X, Y, 0).
savePosition(X, Y, 1) :-
  retract(pos(Pos)),
  append(Pos, [X-Y], NewPos),
  assert(pos(NewPos)).

hasAdjacent :-
  index(IndexList), pos(Pos),
  nth1(1, IndexList, I),
  nth1(I, Pos, X-Y),
  LeftX is X - 1, RightX is X + 1,
  UpY is Y - 1, DownY is Y + 1,
  ite((member(LeftX-Y, Pos), nth1(AdjLeft, Pos, LeftX-Y), \+member(AdjLeft, IndexList)),
    (retract(index(_)), append([AdjLeft], IndexList, NewIndexList), assert(index(NewIndexList)), hasAdjacent),
    ite((member(X-UpY, Pos), nth1(AdjUp, Pos, X-UpY), \+member(AdjUp, IndexList)),
      (retract(index(_)), append([AdjUp], IndexList, NewIndexList), assert(index(NewIndexList)), hasAdjacent),
      ite((member(RightX-Y, Pos), nth1(AdjRight, Pos, RightX-Y), \+member(AdjRight, IndexList)),
        (retract(index(_)), append([AdjRight], IndexList, NewIndexList), assert(index(NewIndexList)), hasAdjacent),
        ite((member(X-DownY, Pos), nth1(AdjDown, Pos, X-DownY), \+member(AdjDown, IndexList)),
          (retract(index(_)), append([AdjDown], IndexList, NewIndexList), assert(index(NewIndexList)), hasAdjacent),
          true)
        )
      )
    ).
