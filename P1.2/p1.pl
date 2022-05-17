%%Exercici 1:

chain(L,R):- chainPerm(L,R), ok(R).

chainPerm([],[]).
chainPerm([H|T],[P|T2]):- permutation(H,P), chainPerm(T,T2).

ok([]).
ok([[_,_]]).
ok([[_,A2],[B1,B2]|L]):- A2 is B1, ok([[B1,B2]|L]).
