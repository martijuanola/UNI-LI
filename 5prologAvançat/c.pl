programa(L) :-
	append(FIRST,SUB,L),
	append(SUB2,LAST,SUB),
	length(FIRST,1),
	length(LAST,1),
	FIRST = ['begin'],
	LAST = ['end'],
	instrucciones(SUB2), write('yes'), nl, !, fail.
programa(_):- write('no'), nl, fail.

instrucciones(L):- instruccion(L).
instrucciones(L):-
	append(SUB1, [';',SUB2], L),
	instruccion(SUB1),
	instrucciones(SUB2).


instruccion([V1,'=',V2,'+',V3]):-
	variable(V1), variable(V2), variable(V3).

instruccion(['if',V1,'=',V2,'then',INSTR]):-
	variable(V1), variable(V2),
	append(I1,[else,I2],INSTR),
	instrucciones(I1),
	append(I22,['endif'],I2),
	instrucciones(I22).

variable(x).
variable(y).
variable(z).


%%Per provar

%% programa( [begin, z, =, x, +, y, end] ).
%% programa( [begin, z, =, x, +, y, ;, x, =, z, z, end] ).