chooseGameMode:-
  displayMainMenu,
  selectOption.

selectOption:-
  read(Option),
  Option > 0,
  Option < 4,
  startPlay(Option).


startPlay(1):-
  create_board(Board),
  game1Vs1(Board).
/*startPlay(2):-
  startGame(...).
startPlay(3):-
  startGame(...).
*/