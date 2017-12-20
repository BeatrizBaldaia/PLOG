%['create_board.pl'],createBoard(4,B-_,A).
%['create_board.pl'],createBoard(20,B-_,A).
:-use_module(library(random)).
createBoard(Dim, Board-[],Square):-
  length(Square, Dim),
  createBoard(Square, Dim),
  append(Square, AuxList),
  checkIntersectedRoads(AuxList, Dim),
  checkSimpleSeparatedRoads(Square),
  LowerBound is Dim // 2,
  UpperBound is 2 * Dim,
  repeat,
  random(LowerBound, UpperBound, NumberOfRodeBlocks),
  placeRodeBlocks(NumberOfRodeBlocks, AuxList),
  placeClues(Board, Dim, AuxList, Dim),
  labeling([],AuxList).

placeRodeBlocks(0,_).
placeRodeBlocks(Number, Board):-
  random_member(1, Board),
  NextNumber is Number - 1,
  placeRodeBlocks(NextNumber, Board).

placeClues([], 0, _, _).
placeClues([X-Y-V|Old], Number, AuxList, BoardDimention):-
  AuxNumber is BoardDimention + 1,
  random(1, AuxNumber, X),
  random(1, AuxNumber, Y),
  getBoardValues(X, Y, AuxList, BoardDimention, Elem, Pos, ValueUpLeft, ValueUp, ValueUpRight, ValueLeft, ValueRight, ValueDownLeft, ValueDown, ValueDownRight),
  Elem #= 0,
  V #= ValueUpLeft + ValueUp + ValueUpRight + ValueLeft + ValueRight + ValueDownLeft + ValueDown + ValueDownRight,
  V #> 0,
  NextNumber is Number - 1,
  placeClues(Old, NextNumber, AuxList, BoardDimention).
