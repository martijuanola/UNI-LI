allEqual([]).
allEqual([_]):- !.
allEqual([A,B|L]) :- A is B, allEqual([B|L]), !.


longestInList([X],X):- !.
longestInList([H|T],H):-
    longestInList(T,RS), length(H, L1), length(RS, L2),
    L1 >= L2, !.
longestInList([H|T],RS):-
    longestInList(T,RS), length(H, L1), length(RS, L2),
    L1 =< L2, !.