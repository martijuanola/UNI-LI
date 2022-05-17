## Useful Tips PROLOG



### To execute SWIPL

```shell
swipl prog.pl
```







### To run commands in SWIPL

Generals:

```
[nameOfProgram].		%% Loads program .pl
ls.									%% ls in terminal
halt.								%% Exit swipl
help.								%% Get help
trace.							%% Enable/Disable trace option
notrace.

```





```swipl
function(input,Y).  %% to get output
function(X,output). %% to get input(calculate f^{-1})

expr is expr 				%% returns boolean
X is expr 					%% returns possible values for X(només si X esta sola?)

!										%% para totes les branques que queden de backtracking
not(X)							%% ???
\+									%% negació d'una clausula

findall(L,cond,S)		%% per aplicar una condició sobre un conjunt
findall(A,B,L) + sort(L,L1) %% per treure repetits de findall
setof(L,cond,S)			%% semblant a findall peròs sense repeticions
select(X,L,R) 			%% L menys elements X és R
	p([],[]).										%% permet comprovar si P és permutació de L
	p(L,[X|P]) :- select(X,L,R), p(R,P).
between(MIN,MAX,X)	%% per assignar o checkejar valors on MIN <= X <= MAX
permutation(S,P)		%% P és permutació de S
subset(Sub,S)				%% Sub és subset de S
length(L,S)					%% Size of list
nth0(I,L,V).				%% El valor de la posició I de L és V

integer(X)					%% True if X is integer
retractall(predicate)% Removes facts and clauses that unify with the predicate

tell(file)					%% Creates new output stream(file .pl)
told								%% Closes output stream(goes back to default(terminal))
see(file)						%%
seen
shell(Command)   		%% Executes a command in terminal

write()							%% escriure per terminal
[_] 								%% variable sense nom, exactament 1 valor
```



Funcions útils:

```
append(L1,L2,L3)
last(L,X)
```



- Després de cada command/conjunt de commands posar un '.'
- Per processar OUPUTS:
  - [space] per obtenir nova possible solució
  - [enter] per no veure'n més
  - Un OUTPUT pot ser:
    - *true*/*false* -> si no hi ha cap possible solució
    - Conjunt de solucions per una variable
