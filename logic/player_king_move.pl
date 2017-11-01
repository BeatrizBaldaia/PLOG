    /*Movimento dos reis sem captura*/


/*
Verificar se o movimento (de uma unidade)
do rei do jogador 1 é valido
*/
validKing1Move(CurrBoard, NewBoard, X-Y, NewX-NewY, Player, Direction):-
  Direction = 2 -> (%para a frente
    findPiece(CurrBoard, X-Y, Player),
  	Y1 is Y + 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X-Y1
  );
  Direction = 8 -> (%para tras
    findPiece(CurrBoard, X-Y, Player),
  	Y1 is Y - 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X-Y1
  );
  Direction = 4 -> (%para a esquerda
    findPiece(CurrBoard, X-Y, Player),
  	X1 is X - 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X1-Y
  );
  Direction = 6 -> (%para a direita
    findPiece(CurrBoard, X-Y, Player),
  	X1 is X - 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X1-Y
  );
  Direction = 7 -> (%tras, diagonal esquerda
    findPiece(CurrBoard, X-Y, Player),
    Y1 is Y - 1,
  	X1 is X - 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X1-Y1
  );
  Direction = 9 -> (%tras, diagonal direita
    findPiece(CurrBoard, X-Y, Player),
    Y1 is Y - 1,
  	X1 is X + 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X1-Y1
  );
  Direction = 1 -> (%frente, diagonal esquerda
    findPiece(CurrBoard, X-Y, Player),
    Y1 is Y + 1,
  	X1 is X - 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X1-Y1
  );
  Direction = 3 -> (%frente, diagonal esquerda
    findPiece(CurrBoard, X-Y, Player),
    Y1 is Y + 1,
  	X1 is X - 1,
  	findPiece(CurrBoard, X-Y1, 0),
  	NewX-NewY is X1-Y1
  ).

  /*
  Verificar se o movimento (de uma unidade)
  do rei do jogador 2 é valido
  */
  validKing2Move(CurrBoard, NewBoard, X-Y, NewX-NewY, Player, Direction):-
    Direction = 8 -> (%para a frente
      findPiece(CurrBoard, X-Y, Player),
    	Y1 is Y - 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X-Y1
    );
    Direction = 2 -> (%para tras
      findPiece(CurrBoard, X-Y, Player),
    	Y1 is Y + 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X-Y1
    );
    Direction = 4 -> (%para a esquerda
      findPiece(CurrBoard, X-Y, Player),
    	X1 is X - 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X1-Y
    );
    Direction = 6 -> (%para a direita
      findPiece(CurrBoard, X-Y, Player),
    	X1 is X - 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X1-Y
    );
    Direction = 1 -> (%tras, diagonal esquerda
      findPiece(CurrBoard, X-Y, Player),
      Y1 is Y + 1,
    	X1 is X - 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X1-Y1
    );
    Direction = 3 -> (%tras, diagonal direita
      findPiece(CurrBoard, X-Y, Player),
      Y1 is Y + 1,
    	X1 is X + 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X1-Y1
    );
    Direction = 7 -> (%frente, diagonal esquerda
      findPiece(CurrBoard, X-Y, Player),
      Y1 is Y - 1,
    	X1 is X - 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X1-Y1
    );
    Direction = 9 -> (%frente, diagonal esquerda
      findPiece(CurrBoard, X-Y, Player),
      Y1 is Y - 1,
    	X1 is X - 1,
    	findPiece(CurrBoard, X-Y1, 0),
    	NewX-NewY is X1-Y1
    ).
