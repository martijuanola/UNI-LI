%%Exercici 2:

all_chains(L):- 
	perms(L,R), permutation(R,R2), chain(R2,CHAINS),
	write(CHAINS), nl, false.
all_chains(_).

perms([],[]).
perms([_|L],R):- perms(L,R).
perms([H|L],[H|R]):- perms(L,R).
