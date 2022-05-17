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


eqSplit(L,S1,S2):- split(L,S1,S2), sumList(S1,A), sumList(S2,A),
	write(S1), write('    '), write(S2), nl, fail.
eqSplit(_,_,_).

split([],[],[]).
split([H|L],[H|S1],S2):- split(L,S1,S2).
split([H|L],S1,[H|S2]):- split(L,S1,S2). 

sumList([],S):- S is 0.
sumList([H|L],S):- sumList(L,S2), S is S2 + H.

%% Funcions per l'anterior versió

subset([],[]).
subset([X|L],[X|S]) :- subset(L,S).
subset([_|L],S) :- subset(L,S).

listSubtract([],_,[]).
listSubtract([H|L],LS,LR):- member(H,LS), listSubtract(L,LS,LR), !.
listSubtract([H|L],LS,[H|LR2]):- listSubtract(L,LS,LR2).