initial_state(state(0,0)).
goal_state([state(0,4)]).

capacity(m,3).
capacity(n,5).

move(a1,state(_X,Y),state(M,Y)):-
    capacity(m,M).
move(a2,state(X,Y),state(0,Y)):-
    X>0.
move(a3,state(X,Y),state(X,N)):-
    capacity(n,N),Y<N.
move(a4,state(X,Y),state(X,0)):-
    Y>0.
move(a5,state(X,Y),state(0,Y1)):-
     X>0,
    capacity(n,N),
    Y1 is X+Y,
    Y1=<N.

move(a6, state(X,Y), state(X1,N)) :- 
    capacity(n, N),
    Y1 is X + Y,
    Y1 >= N,
    X1 is Y1 - N. 
move(a7,state(X,Y),state(X1,0)):-
    Y>0,
    capacity(m,M),
    X1 is X+Y,
    X1 =<M.
move(a8,state(X,Y),state(M,Y1)):-
    capacity(m,M),
    Y>0,
    X1 is X+Y,
    X1>=M,
    Y1 is X1-M.

find_path(CS,LGS,Pathsofar,Path):-
    member(CS,LGS),
    reverse(Pathsofar,Path).
find_path(CS,LGS,Pathsofar,Path):-
    not(member(CS,LGS)),
    move(_Act,CS,NS),
    not(member(NS,Pathsofar)),
    find_path(NS,LGS,[NS|Pathsofar],Path).

get_path(Path):-
    initial_state(IS),
    goal_state(LGS),
    find_path(IS,LGS,[IS],Path).