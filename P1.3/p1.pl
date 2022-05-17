%%Exercici 1:

path([[S,F]], S, F):- !.
path(L, S, F):- select([S,M], L, R), path(R, M, F),!.
