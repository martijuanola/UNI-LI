%%%%% MODULES
:- use_module(library(lists)).


%%%%%% P1 
prod([X],X).
prod([X|L],P) :- prod(L,P2), P is X*P2.


%%%%%% P2
pescalar([],[],0).
pescalar([_],[],_) :- fail.
pescalar([],[_],_) :- fail.
pescalar([E1|R1],[E2|R2],R) :-
	P is E1 * E2,
	pescalar(R1,R2,Raux),
	R is P + Raux.


%%%%%% P3
intersect([],_,[]).
intersect([X|L1],L2,[X|R]) :-
	member(X,L2), removeElem(X,L2,AUX), intersect(L1,AUX,R).
intersect([_|L1],L2,R) :- intersect(L1,L2,R).

removeElem(X, L, NewL):- 
	append(L1, [X|L2], L), append(L1, L2, NewL).


%%%%%% P4
%last(L1,Y) :- concat(_,X,L1), length(X,1), member(Y,X).
myLast(L,X) :- concat(_,[X],L).

myReverse([],[]).
myReverse([X|L1],L2) :- last(L2,X), removeLast(L2,L2aux),
	myReverse(L1,L2aux).

%removeLastElem(L,NewL) :- last(L,X), concat(NewL,[X],L).
removeLast(L,NewL) :- append(NewL,[_],L).


%%%%%% P5
fib(1,1).
fib(2,1).
fib(N,F) :- N1 is N-1, N2 is N-2, fib(N1,F1), fib(N2,F2), F is F1 + F2.

%%%%%% P6
dados(0,0,[]).
dados(P,N,[X|L]) :- N > 0,
	member(X,[1,2,3,4,5,6]),
	P2 is P - X,
	N2 is N - 1,
	dados(P2,N2,L).

%%%%%% P7
suma_demans(L) :-
	append(L1,_,L),
	last(L1,X),
	sum_list(L,SL),
	X is SL-X, write(X).

%%%%%% P8
suma_ants(L) :-
	append(L1,_,L),
	last(L1,X),
	sum_list(L1,SL),
	X is SL-X, write(X).

%%%%%% P9
card(L) :-
	cards(L,R), write(R).

cards([],[]).
cards([X|L],[[X|C]|R]) :-
	cards(L,R2),
	removeCard([X|OC],R2,R),
	C is OC + 1, !.
cards([X|L],[[X|1]|R]) :-
	cards(L,R).

removeCard(X,L1,L2) :-
	append(PL1,[X|PL2],L1),
	append(PL1,PL2,L2).


count_in(_,[],0).
count_in(X,[X|L],C) :-
	count_in(X,L,C2),
	C is 1 + C2, !.
count_in(X,[_|L],C) :- 
	count_in(X,L,C).

removeAll(_,[],[]).
removeAll(X,[X|T],L) :- removeAll(X,T,L), !.
removeAll(X,[H|T],[H|L]) :- removeAll(X,T,L).


%%%%%% P10
esta_ordenada([]) :- !.
esta_ordenada([_]) :- !.
%esta_ordenada([F|L]) :- first(L,S), F =< S, esta_ordenada(L).
esta_ordenada([A,B|L]) :- A =< B, esta_ordenada([B|L]).

first(L,X) :- append([X],_,L).


%%%%%% P11
ord(L1,L2) :- permutation(L1,L2), esta_ordenada(L2), !.


%%%%%% P12
diccionario(A,N) :- diccionario(A,N,L), printString(L), write("\n"), fail.

diccionario(_,0,[]) :- !.
diccionario(A,N,[X|L2]) :-
	N2 is N - 1,
	member(X,A),
	diccionario(A,N2,L2).

printString([]).
printString([C|L]) :- write(C), printString(L).


%%%%%% P13
palindromos(L) :- setof(P,palindromos(L,P),R), write(R).

palindromos(L,P) :- permutation(L,P), palindrom(P).

palindrom([]).
palindrom([_]).
palindrom([X|L]) :-
	last(L,Y), X == Y,
	append(L2,[Y],L), palindrom(L2).


%%%%%% P14
sendMoreMoney() :-
	LL = [S,E,N,D,M,O,R,Y,_,_],
	NN = [0,1,2,3,4,5,6,7,8,9],
	permutation(LL,NN),
	S1 is S*1000 + E*100 + N*10 + D,
	S2 is M*1000 + O*100 + R*10 + E,
	S3 is M*10000 + O*1000 + N*100 + E*10 + Y,
	S3 is S2 + S1,
	write(LL), !.


%%%%%% P15 ???


%%%%%% P16
dom(L) :- p(L,P), ok(P), write(P), nl.
dom(_) :- write("no hay cadena"), nl.

%Comprova que P és permutació de L
p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).
p(L,[f(X,Y)|P]) :- select(f(Y,X),L,R), p(R,P).

%Comprova que P és una cadena de domino
ok([f(_,_)]).
ok([f(_,F2),f(S1,S2)|P]) :- F2 = S1, ok([f(S1,S2)|P]).



%% FALTA ACABAR!!!
%%%%%% P17
p :- readclauses(F), sat([],F).
p :- write("UNSAT"),nl.
 
%sat(I,[]) :- write("IT IS SATISFIABLE. Model: ""), write(I),nl,!.
%sat(I,F) :- 
%	decision_lit(F,Lit), % Select unit clause if any; otherwise, an arbitrary one.
%	simplif(Lit,F,F1), % Simplifies F. Warning: may fail and cause backtracking
%	sat( , ).%%falta això

decision_lit(F,Lit) :-
	append(_,[[Lit]|_],F),
	length(Lit,1).
decision_lit(F,Lit) :- member(Lit,F).

%simplif(Lit,F,F1).%%falta això


%% FALTA ACABAR!!!
%%%%%% P18
cancerFumadors() :-
	between(0,10,CF1),
	between(0,10,CF2),
	between(0,10,C1),
	between(0,10,C2),
	between(0,10,F1),
	between(0,10,F2),
	between(0,10,R1),
	between(0,10,R2),

	CF1 + C1 + F1 + R1 = 10,
	CF2 + C2 + F2 + R2 = 10,
	CF1 div F1 > C1 div R1,
	CF2 div F2 > C2 div R2,
	(CF1 + CF2) div (F1 + F2) =< (C1 + C2) div (R1 + R2),

	write("CANCER I FUMEN"), write(CF1),
	write("FUMEN"), write(F1),
	write("CANCER"), write(C1),
	write("RES"), write(R1).
	%%suma de els dos sigui al reves


%%%%%% P19
maq(V,C,M) :-
	length(V,VL),
	length(M,VL),
	between(0,C,MIN),
	lessThan(MIN,M),
	maqSum(V,C,M),
	write(M), write("\n"), halt.

maqSum(_,0,[]).
maqSum([VF|V],C,[LF|L]) :-
	LF >= 0,
	C >= 0,
	C2 is C - VF*LF,
	maqSum(V,C2,L).

lessThan(_,[]).
lessThan(MAX,[F|L]) :-
	between(0,MAX,F),
	MAX2 is MAX - F,
	lessThan(MAX2,L).


%%%%%% P20
myFlatten([],[]) :- !.
myFlatten([X|L],R) :-
	myFlatten(X,XF),
	myFlatten(L,LF),
	append(XF,LF,R), !.
myFlatten(X,[X]).


%% FALTA ACABAR!!!
%%%%%% P21

%Solució Jaume
log2(_, 1, 0) :- !.
log2(B, N, L) :- 
    N1 is div(N,B), log2(B, N1, L1), L is L1+1.


%% FALTA ACABAR!!!
%%%%%% P22




%% PROBLEMA ANGEL
ocurrencies(X,L,O):- auxOcurrencies(X,L,O,0).

auxOcurrencies(_,[],[],_).
auxOcurrencies(X,[X|L],[N|O2],N):- N2 is N+1, auxOcurrencies(X,L,O2,N2), !.
auxOcurrencies(X,[_|L],O,N):- N2 is N+1, auxOcurrencies(X,L,O,N2).



%%%%%% FUNCIONS DE CLASSE %%%%%%

%%%%%% FACTORIAL 
fact(0,1).
fact(N,F) :-
	N1 is N-1,
	fact(N1,F1),
	F is N*F1.

%%%%%% NATURAL
natural(0).
natural(N) :- N1 is N - 1, natural(N1).

%%no funciona, s'hauria de mirar
%nat(0).
%nat(N):- nat(N1), N is N1 + 1.

%%%%%% NOT 
not(X) :- X,!,fail.
not(_).

%%%%%% CONCAT
concat([],L,L).
concat([X|L1],L2,[X|L3]) :- 
	concat(L1,L2,L3).

%la funció member(X,[L]) ho implementa member
%memberOf([X|_],X).
%memberOf([_|L],X) :- member(L,X).

%%%%%% FACTORS
factores(1,[]) :- !.
factores(N,[F,L]) :-
	natural(F), F > 1, 0 is N mod F,
	N1 is N // F, factores(N1,L).

%%%%%% JUEGO DADOS???
jugeoDados :-
	permutation([1,2,3,4,5,6,7,8,9],[R1,R2,R3,V1,V2,V3,A1,A2,A3]),
	gana([R1,R2,R3],[V1,V2,V3]),
	gana([V1,V2,V3],[A1,A2,A3]),
	gana([A1,A2,A3],[R1,R2,R3]),
	write([R1,R2,R3,V1,V2,V3,A1,A2,A3]),nl.

gana(D1,D2) :-
	findall(X-Y, (member(X,D1), member(Y,D2), X>Y), L),
	length(L,K), K>=5.

%%%%%% PROBLEMES DE CLASSE %%%%%%

%%%%%% Exercici dels apunts CIFRAS
%%%%%%
cifras(L,N):-
	subset(L,S),
	permutation(S,P),
	expression(P,E),
	N is E,
	write(E), nl, fail.

expression([X],X).
expression(L, E1+E2):-
	append(L1,L2,L), L1\=[], L2\=[],
	expression(L1,E1),
	expression(L2,E2).
expression(L, E1-E2):-
	append(L1,L2,L), L1\=[], L2\=[],
	expression(L1,E1),
	expression(L2,E2).
expression(L, E1*E2):-
	append(L1,L2,L), L1\=[], L2\=[],
	expression(L1,E1),
	expression(L2,E2).
expression(L, E1//E2):-
	append(L1,L2,L), L1\=[], L2\=[],
	expression(L1,E1),
	expression(L2,E2), X is E2, X\=0.

mySubset([],[]).
mySubset([X|L],[X|S]) :- mySubset(L,S).
mySubset([_|L],S) :- mySubset(L,S).



