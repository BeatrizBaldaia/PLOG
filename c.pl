f(A):- get_code(A),
	get_code(B),
	put_code(A).

getInput(A):-
	get_code(A),
	get_code(B),
	write(A),nl,
	put_code(A).
getInteger(R):-
    get_code(A),
	get_code(B),
	write(A),
	isInteger(A, R).
isInteger(49, 1).
isInteger(50, 2).
isInteger(51, 3).
isInteger(52, 4).
isInteger(53, 5).
isInteger(54, 6).
isInteger(55, 7).
isInteger(56, 8).

getLetter(R):-
	repeat,
    	get_code(A),
		write(A).
