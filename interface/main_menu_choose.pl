chooseGameMode:-
  displayMainMenu,
  selectOption.

selectOption:-
  getInteger(Option),
  Option > 0,
  Option < 5,
  startPlay(Option).


startPlay(1):-
  create_board(Board),
  game1Vs1(Board).

startPlay(2):-
  create_board(Board),
  game1vsPC(Board).

startPlay(3):-
  create_board(Board),
  gamePCvsPC(Board).

startPlay(4):-
  retract(level(_L)),
  ite(_L = 1,
	Level = 2,
	Level = 1),
  assert(level(Level)),
  ite(Level = 1,
	write('Playing in random level!'),
	write('Playing in difficult level!')),
  chooseGameMode.
