%% Problema A
a :-
	R = [
		[1,_,_,_,_,_],
		[2,_,_,_,_,_],
		[3,_,_,_,_,_],
		[4,_,_,_,_,_],
		[5,_,_,_,_,_]],
	member([_,roja,_,_,_,peru],R),
	member([_,_,_,perro,_,francia],R),
	member([_,_,pintor,_,_,japon],R),
	member([_,_,_,_,ron,china],R),
	member([1,_,_,_,_,hungria],R),
	member([_,verde,_,_,conyac,_],R),
	
	member([R1,verde,_,_,_,_],R),
	member([R2,blanca,_,_,_,_],R),
	esquerra(R1,R2),

	member([_,_,escultor,caracol,_,_],R),
	member([_,amarilla,actor,_,_,_],R),
	member([3,_,_,_,cava,_],R),

	member([R3,_,actor,_,_,_],R),
	member([R4,_,_,caballo,_,_],R),
	vei(R3,R4),

	member([R5,azul,_,_,_,_],R),
	member([R6,_,_,_,_,hungria],R),
	vei(R5,R6),

	member([_,_,notario,_,whisky,_],R),
	
	member([R7,_,medico,_,_,_],R),
	member([R8,_,_,ardilla,_,_],R),
	vei(R7,R8),

	write(R), nl.

	%member([_,_,_,_,_,_,_],R),

dreta(N1,N2) :- N1 is N2 + 1. 
esquerra(N1,N2) :- N2 is N1 + 1.

vei(N1,N2):- dreta(N1,N2).
vei(N1,N2):- esquerra(N1,N2).

