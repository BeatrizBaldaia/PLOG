checkClearLine([], _, 0).
checkClearLine([Row|OtherRows], State, Result):-
  count(1, Row, #=, Count),
  (Count #>= 1 #/\ State #= 0) #<=> B,
  Result #= ResultAux + B,
  checkClearLine(OtherRows, Count, ResultAux).

checkSimpleSeparatedRoads(Matrix) :-
  checkClearLine(Matrix, 0, Result1),
  transpose(Matrix, TransposeMatrix),
  checkClearLine(TransposeMatrix, 0, Result2),
  Result1 #= 1, Result2 #= 1.
