main:-
   EstadoInicial = [3,3,0,0,0],
   EstadoFinal = [0,0,1,3,3],
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


% 1 misioner
unPaso(1,[M1,C1,0,M2,C2],[M12,C1,1,M22,C2]) :-
   member(N, [1,2]),
   M1 >= N,
   M12 is M1 - N,
   M22 is M2 + N,
   noEsMaten(M12,C1), noEsMaten(M22,C2).
unPaso(1,[M1,C1,1,M2,C2],[M12,C1,0,M22,C2]) :-
   member(N, [1,2]),
   M2 >= N,
   M12 is M1 + N,
   M22 is M2 - N,
   noEsMaten(M12,C1), noEsMaten(M22,C2).

% 1 de cada
unPaso(1,[M1,C1,0,M2,C2],[M12,C12,1,M22,C22]) :-
   M1 > 0, C1 > 0,
   M12 is M1 - 1,
   M22 is M2 + 1,
   C12 is C1 - 1,
   C22 is C2 + 1.
unPaso(1,[M1,C1,1,M2,C2],[M12,C12,0,M22,C22]) :-
   M2 > 0, C2 > 0,
   M12 is M1 + 1,
   M22 is M2 - 1,
   C12 is C1 + 1,
   C22 is C2 - 1.

% 1 canibal
unPaso(1,[M1,C1,0,M2,C2],[M1,C12,1,M2,C22]) :-
   member(N, [1,2]),
   C1 >= N,
   C12 is C1 - N,
   C22 is C2 + N,
   noEsMaten(M1,C12), noEsMaten(M2,C22).
unPaso(1,[M1,C1,1,M2,C2],[M1,C12,0,M2,C22]) :-
   member(N, [1,2]),
   C2 >= N,
   C12 is C1 + N,
   C22 is C2 - N,
   noEsMaten(M1,C12), noEsMaten(M2,C22).

%% correcto([M1,C1,_,M2,C2]):-
%%    M1 >= 0, M1=<3, C1 >= 0, C1=<3, 
%%    M2 >= 0, M2=<3, C2 >= 0, C2=<3, 
%%    noEsMaten(M1, C1),
%%    noEsMaten(M2, M2),!.


noEsMaten(0,_).
noEsMaten(M,C):-
   M >= C.



