:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
%% VARIABLES
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),
    append([D1,D2,D3,D4],DALL),


%% DOMAINS
    D1 ins 1..24,
    D2 ins 1..24,
    D3 ins 1..24,
    D4 ins 1..24,

%% CONSTRAINS
    findSets(DS),
    notInSameDice(DS,D1),
    notInSameDice(DS,D2),
    notInSameDice(DS,D3),
    notInSameDice(DS,D4),

    all_different(DALL),

    %% coses per trencar la simetria i que vagi més ràpid
    %% romper_simetria_1(D1, D2),
    %% sortedOK(D1), sortedOK(D2), sortedOK(D3), sortedOK(D4), 

%% LABELING
    
    labeling([ff],DALL),


%% PRINT SOLUTION
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    
writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.

findSets(DS) :-
    findall(L1-L2, (word(W), member(A,W), member(B,W), num(A,L1), num(B,L2), L1 < L2), DS).

%% notInSameDice([], _).
%% notInSameDice([L1-L2|T],[F1,F2,F3,F4,F5,F6]) :-
%%     notInSameDice(T,[F1,F2,F3,F4,F5,F6]),
%%     F1 #\= L1 #\/ F2 #\= L2, F1 #\= L1 #\/ F3 #\= L2, F1 #\= L1 #\/ F4 #\= L2, F1 #\= L1 #\/ F5 #\= L2, F1 #\= L1 #\/ F6 #\= L2,
%%     F2 #\= L1 #\/ F3 #\= L2, F2 #\= L1 #\/ F4 #\= L2, F2 #\= L1 #\/ F5 #\= L2, F2 #\= L1 #\/ F6 #\= L2,
%%     F3 #\= L1 #\/ F4 #\= L2, F3 #\= L1 #\/ F5 #\= L2, F3 #\= L1 #\/ F6 #\= L2,
%%     F4 #\= L1 #\/ F5 #\= L2, F4 #\= L1 #\/ F6 #\= L2,
%%     F5 #\= L1 #\/ F6 #\= L2.
   
notInSameDice([], _).
notInSameDice([L1-L2|T],[F1,F2,F3,F4,F5,F6]) :-
    notInSameDice(T,[F1,F2,F3,F4,F5,F6]),
    const(L1,L2,F1,F2), const(L1,L2,F1,F3), const(L1,L2,F1,F4), const(L1,L2,F1,F5), const(L1,L2,F1,F6),
    const(L1,L2,F2,F3), const(L1,L2,F2,F4), const(L1,L2,F2,F5), const(L1,L2,F2,F6),
    const(L1,L2,F3,F4), const(L1,L2,F3,F5), const(L1,L2,F3,F6),
    const(L1,L2,F4,F5), const(L1,L2,F4,F6),
    const(L1,L2,F5,F6).
    

const(L1,L2,F1,F2) :- 
    L1 #\= F1 #\/ L2 #\= F2.



%romper_simetria_1([A|_], [B|_], [C|_], [D|_]) :- A #= 2, B #= 1, C #= 11, D #= 5. %b, a, k, e
romper_simetria_1([A|_], [B|_]) :- A #= 2, B #= 1. %b, a. k, e no les poso pq potser no estarà sorted sinó!!

%Es pot trencar simetria fent tb que estigui sorted
sortedOK([_]).                                          %%%% OK!
sortedOK([X,Y|L]):- X #< Y, sortedOK([Y|L]).






