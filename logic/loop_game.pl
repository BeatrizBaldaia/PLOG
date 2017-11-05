/*game1Vs1(Board):-
  displayPlayer1Turn,
  selectPiece(Board, NewBoard1, 1),
  \+gameOver(NewBoard1, 2) -> (
  displayPlayer2Turn,
  selectPiece(NewBoard1, NewBoard2, 2),
  \+gameOver(NewBoard2, 1),
  game1Vs1(NewBoard2)
  ).*/
:- dynamic gameState/2.

game1Vs1(InitialBoard):-
  assert(gameState(InitialBoard, 1)),
	repeat,
		retract(gameState(Board, Player)),
		once(playGame(Player, Board, NewPlayer, NewBoard1)),
		once(promotedToKing(NewBoard1, NewBoard)),
		assert(gameState(NewBoard, NewPlayer)),
  %  assert(gameState(NewBoard1, NewPlayer)),
		gameOver(NewBoard, NewPlayer).

playGame(Player, CurrBoard, NewPlayer, NewBoard):-
  write('\33\[2J'),
  ite(Player = 1, displayPlayer1Turn, displayPlayer2Turn),
  mandatoryCapture(CurrBoard, NewBoard, Player),
  ite(Player = 1, NewPlayer is 2, NewPlayer is 1).

mandatoryCapture(CurrBoard, NewBoard, Player):-
	findall(Num-Moves,getCapturesList(CurrBoard, X-Y, Player, Moves, Num), L),
  sort(L, LSorted),
	reverse(LSorted, LInverted),
  nth1(1, LInverted, NCaptures-BestMove),
  getBestCaptures(LInverted, Best, [], NCaptures),
  write('Best:  '), write(Best), nl, nl, nl,
  ite(NCaptures = 0,
		selectPiece(CurrBoard, NewBoard, Player),
		(nl, nl, write('WARNING: You\'re forced to capture'), nl, nl,
    selectCapturePiece(CurrBoard, Player, Best, NCaptures, NewBoard))
		).

gamePCvsPC(InitialBoard):-
	retractall(keep(_A,_B)),
  assert(keep(InitialBoard, 1)),
	repeat,
		retract(keep(Board, Player)),
		once(playGamePC(Player, Board, NewPlayer, NewBoard1)),
		once(promotedToKing(NewBoard1, NewBoard)),
		assert(keep(NewBoard, NewPlayer)),
    sleep(3),
		gameOver(NewBoard, NewPlayer).

playGamePC(Player, Board, NewPlayer, NewBoard):-
  write('\33\[2J'),
  ite(Player = 1,(displayPlayer1Turn, NewPlayer = 2),(displayPlayer2Turn, NewPlayer = 1)),
  showBoard(Board),
  validMovesPC(Board, Player, Moves, Simple),
  chooseMovePC(Moves, Move),
  applyMovePC(Board, NewBoard, Move, Player, Simple).


game1vsPC(InitialBoard):-
  retractall(gameState(_A,_B)),
  assert(gameState(InitialBoard, 1)),
	repeat,
		retract(gameState(Board, Player)),
		once(playGamePCorPlayer(Player, Board, NewPlayer, NewBoard1)),
		once(promotedToKing(NewBoard1, NewBoard)),
		assert(gameState(NewBoard, NewPlayer)),
		gameOver(NewBoard, NewPlayer).

playGamePCorPlayer(Player, Board, NewPlayer, NewBoard):-
	ite(Player = 1,
		playGame(Player, Board, NewPlayer, NewBoard),
		playGamePC(Player, Board, NewPlayer, NewBoard)).
