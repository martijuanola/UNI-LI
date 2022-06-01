main:-
   EstadoInicial = [0,0],
   EstadoFinal = [0,4],
   between(1,1000,CosteMax), % Buscamos soluci ́on de coste 0; si no, de 1, etc.
   camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
   reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.


camino( 0, E,E, C,C ).              % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
   CosteMax>0,
   unPaso( CostePaso, EstadoActual, EstadoSiguiente ),  % En B.1 y B.2, CostePaso es 1.
   \+member( EstadoSiguiente, CaminoHastaAhora ),
   CosteMax1 is CosteMax-CostePaso,
   camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).


unPaso(1,[_,B],[5,B]).
unPaso(1,[A,_],[A,8]).

unPaso(1,[A,_],[A,0]).
unPaso(1,[_,B],[0,B]).

unPaso(1,[A,B],[A2,B2]):-
   D is min(A,8-B),
   A2 is A - D,
   B2 is B + D.

unPaso(1,[A,B],[A2,B2]):-
   D is min(B,5-A),
   A2 is A + D,
   B2 is B - D.