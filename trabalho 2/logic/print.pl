/*Predicado Para Mostrar o Tabuleiro*/
showBoard(X):- !,nl,showRow(X, 1).
showRow(X, Y):- X = [],!.
showRow(X, Y):- !,X = [H|R],
	Yn is (Y + 1),
	write('--------------------------------------------------------------------------------------------'), nl,
	showRowValues(H), nl,
	showRow(R, Yn).
showRowValues(X):- X = [] ,!, write(' |').
showRowValues(X):- !,X = [H|R],
	write(' | '),
	showPiece(H),
	showRowValues(R).
showPiece(X):- X = 1,!,
	put_code(219).
showPiece(X):- X = 0,!,
	write(' ').
showPiece(X):- !,X = 2,
  	put_code(65).
%showPiece(X):- put_code(66).
