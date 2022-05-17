%% Exercici 2:

path(_, F, F):- !.
path(L, S, F):- select([S,M], L, R), path(R, M, F),!.

negate(\+X,X):-!.
negate(X,\+X).

sat(N,S):-
   findall([NX,Y], (member([X,Y],S), negate(X,NX)), G1), 
   findall([NY,X], (member([X,Y],S), negate(Y,NY)), G2),
   append(G1,G2,G),
   write(G),
   \+badCycle(N,G).


badCycle(N,G):- 
   between(1,N,I), negate(I,NI), path(G,I,NI), path(G,NI,I).