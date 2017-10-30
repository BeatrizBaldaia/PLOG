chooseGame:-
  displayMainMenu,
  selectOption.

selectOption:-
  read(Option),
  Option > 0,
  Option < 4,
  startPlay(Option).

/*
startPlay(1):-
  startGame(...).
startPlay(2):-
  startGame(...).
startPlay(3):-
  startGame(...).
*/
