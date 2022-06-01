%% Write a Prolog predicate eqSplit(L,S1,S2) that, given a list of
%% integers L, splits it into two disjoint subsets S1 and S2 such that
%% the sum of the numbers in S1 is equal to the sum of S2. It should
%% behave as follows:
%%
%% ?- eqSplit([1,5,2,3,4,7],S1,S2), write(S1), write('    '), write(S2), nl, fail.
%%
%% [1,5,2,3]    [4,7]
%% [1,3,7]    [5,2,4]
%% [5,2,4]    [1,3,7]
%% [4,7]    [1,5,2,3]


main:- eqSplit([1,5,2,3,4,7],S1,S2), write(S1), write('    '), write(S2), nl, fail.
main.

eqSplit(L,S1,S2) :- subset2(L,S1,S2), sumElems(S1,SS1), sumElems(S2,SS1).

sumElems([],0).
sumElems([H|T],R):- sumElems(T,R2), R is H+R2.

subset2([],[],[]).
subset2([H|T],[H|S1],S2) :- subset2(T,S1,S2).
subset2([H|T],S1,[H|S2]) :- subset2(T,S1,S2).