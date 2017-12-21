
%['trace_rode.pl'],calculate_road([2-2-5,5-2-5,3-3-3,2-5-3,6-6-2]-[5-4],6,RES),showBoard(RES,[2-2-5,5-2-5,3-3-3,2-5-3,6-6-2]-[5-4],6).
/*Predicado Para Mostrar o Tabuleiro*/
showBoard(Solution,Board-Zeros,Dim):- !,createPrintBoard(Solution,Board-Zeros,Dim,X),nl,showRow(X, 1,Dim).
showRow(X, Y,Dim):- X = [],!.
showRow(X, Y,Dim):- !, X = [H|R],
	Yn is (Y + 1),
	writeSlash(Dim),
	nl,
	showRowValues(H), nl,
	showRow(R, Yn,Dim).

showRowValues(X):- X = [] ,!, write(' |').
showRowValues(X):- !,X = [H|R],
	write(' | '),
	showPiece(H),
	showRowValues(R).

showPiece(X):- X = 11,!,
	put_code(9619).
showPiece(X):- X = 10,!,
	write(' ').
showPiece(X):- X = 9,!,
	put_code(9209).
showPiece(X):- write(X).

writeSlash(0):-!.
writeSlash(Dim):-
	write('----'),
	ND is Dim - 1,
	writeSlash(ND).

createPrintBoard(Solution,Clues-Zeros,Dim,Square):-
	length(Square, Dim),
  createPBoard(Square, Dim),
	putZeros(Square,Zeros),
	putClues(Square,Clues),
	putPath(Solution,Square).

putPathLin([],[]).
putPathLin([S|LinSol],[Q|LinSqu]):-
	ite(nonvar(Q),true,(Elem is S + 10,Q is Elem)),
	putPathLin(LinSol,LinSqu).

putPath([],[]).
putPath([LinSol|Solution],[LinSqu|Square]):-
	putPathLin(LinSol,LinSqu),
	putPath(Solution,Square).

putClues(_,[]).
putClues(Square,[X-Y-V|Clues]):-
	nth1(Y,Square,Lin),
	nth1(X,Lin,V),
	putClues(Square,Clues).
	
putZeros(_,[]).
putZeros(Square,[X-Y|Zeros]):-
	nth1(Y,Square,Lin),
	nth1(X,Lin,9),
	putZeros(Square,Zeros).
createPBoard([H],Dim):-
	length(H, Dim).
createPBoard([H|Answer], Dim):-
	length(H, Dim),
	createPBoard(Answer, Dim).
