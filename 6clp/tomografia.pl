% A matrix which contains zeroes and ones gets "x-rayed" vertically and
% horizontally, giving the total number of ones in each row and column.
% The problem is to reconstruct the contents of the matrix from this
% information. Sample run:
%
%	?- p.
%	    0 0 7 1 6 3 4 5 2 7 0 0
%	 0                         
%	 0                         
%	 8      * * * * * * * *    
%	 2      *             *    
%	 6      *   * * * *   *    
%	 4      *   *     *   *    
%	 5      *   *   * *   *    
%	 3      *   *         *    
%	 7      *   * * * * * *    
%	 0                         
%	 0                         
%	
%% [tomografia].

:- use_module(library(clpfd)).

ejemplo1( [0,0,8,2,6,4,5,3,7,0,0], [0,0,7,1,6,3,4,5,2,7,0,0] ).
ejemplo2( [10,4,8,5,6], [5,3,4,0,5,0,5,2,2,0,1,5,1] ).
ejemplo3( [11,5,4], [3,2,3,1,1,1,1,2,3,2,1] ).

%--------------------------------

p:-	ejemplo1(RowSums,ColSums),
	length(RowSums,NumRows),
	length(ColSums,NumCols),
	NVars is NumRows*NumCols,

%1. domini
	listVars(NVars,L),  % generate a list of Prolog vars (their names do not matter)
	matrixByRows(L,NumCols,MatrixByRows),
	transpose(MatrixByRows,TransposedMatrix),

%2. constrains
	declareConstraints(MatrixByRows,TransposedMatrix,RowSums,ColSums),

%3. labeling
	label(L),

%4. solution
	pretty_print(RowSums,ColSums,MatrixByRows).

%--------------------------------
listVars(NVars, L):-
	length(L, NVars),
	L ins 0..1.
    
% Create a Matrix of NumCols columns from all variables in the list.
matrixByRows(L, NumCols, MatrixByRows):-
            length(L, Lsize),
            NumRows is Lsize div NumCols,
            length(MatrixByRows, NumRows), 
            maplist(checkLength(NumCols), MatrixByRows), % All rows have length NumCols
            append(MatrixByRows, L).
            
% maplist(:Goal, ?List)
% True if Goal can successfully be applied on all elements of List. 
% Arguments are reordered to gain performance as well as to make the predicate deterministic under normal circumstances.
            
checkLength(Length, List):- length(List, Length).

declareConstraints(MatrixByRows,TransposedMatrix,RowSums,ColSums):- 
   check(MatrixByRows, RowSums),
   check(TransposedMatrix, ColSums).
                   
check([], []):- !.
check([H|T], [HS|TS]):- sum(H, #=, HS), check(T, TS).

pretty_print(_,ColSums,_):- write('     '), member(S,ColSums), writef('%2r ',[S]), fail.
pretty_print(RowSums,_,M):- nl,nth1(N,M,Row), nth1(N,RowSums,S), nl, writef('%3r   ',[S]), member(B,Row), wbit(B), fail.
pretty_print(_,_,_):- nl.
wbit(1):- write('*  '),!.
wbit(0):- write('   '),!.
    
