main:-
   EstadoInicial = [0,0,0,0,0],
   EstadoFinal = [1,1,1,1,1],
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

canviCostat(0,1).
canviCostat(1,0).

unPaso(8,[P1,P2,P5,P8,L],[P1,P2,P5,P82,L2]):-
   P8 = L,
   canviCostat(P8,P82), canviCostat(L,L2).
unPaso(8,[P1,P2,P5,P8,L],[P1,P2,P52,P82,L2]):-
   P8 = L, P5 = P8,
   canviCostat(P8,P82), canviCostat(L,L2), canviCostat(P5,P52).
unPaso(8,[P1,P2,P5,P8,L],[P1,P22,P5,P82,L2]):-
   P8 = L, P2 = P8,
   canviCostat(P8,P82), canviCostat(L,L2), canviCostat(P2,P22).
unPaso(8,[P1,P2,P5,P8,L],[P12,P2,P5,P82,L2]):-
   P8 = L, P1 = P8,
   canviCostat(P8,P82), canviCostat(L,L2), canviCostat(P1,P12).

unPaso(5,[P1,P2,P5,P8,L],[P1,P2,P52,P8,L2]):-
   P5 = L,
   canviCostat(P5,P52), canviCostat(L,L2).
unPaso(5,[P1,P2,P5,P8,L],[P1,P22,P52,P8,L2]):-
   P5 = L, P2 = P5,
   canviCostat(P5,P52), canviCostat(L,L2), canviCostat(P2,P22).
unPaso(5,[P1,P2,P5,P8,L],[P12,P2,P52,P8,L2]):-
   P5 = L, P1 = P5,
   canviCostat(P5,P52), canviCostat(L,L2), canviCostat(P1,P12).

unPaso(2,[P1,P2,P5,P8,L],[P1,P22,P5,P8,L2]):-
   P2 = L,
   canviCostat(P2,P22), canviCostat(L,L2).
unPaso(5,[P1,P2,P5,P8,L],[P12,P22,P5,P8,L2]):-
   P2 = L, P2 = P1,
   canviCostat(P2,P22), canviCostat(L,L2), canviCostat(P1,P12).

unPaso(1,[P1,P2,P5,P8,L],[P12,P2,P5,P8,L2]):-
   P1 = L,
   canviCostat(P1,P12), canviCostat(L,L2).

