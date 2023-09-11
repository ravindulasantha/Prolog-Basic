initial_state(s(1,1,2,2,1,1,_)).
goal_state(s(0,0,0,0,0,0_)).

unsafe(s(F,M,S,D,P,T,_)) :-
    N is F + M + D + S,
    (   P=0,T=1,N>0);
    (   P=1,T=0,N<6).

unsafe(s(F,M,S,D,P,T,_)):-
    (   M=1,F=0,D>0);
    (   M=0,F=1,D<2).

unsafe(s(F,M,S,D,P,T,_)):-
    (   M=0,F=1,S>0);
    (   M=1,F=0,S<2).

safe(S) :-  not(unsafe(S)).

move(farther-w-e, s(1,M,S,D,P,T,1), s(0,M,S,D,P,T,0)):-
    safe(s(0,M,S,D,P,T,0)).

move(farther-e-w, s(0,M,S,D,P,T,0), s(1,M,S,D,P,T,1)):-
    safe(s(1,M,S,D,P,T,1)).

move(farther_takes_mother-w-e, s(1,1,S,D,P,T,1), s(0,0,S,D,P,T,0)):-
    safe(s(0,0,S,D,P,T,0)).

move(farther_takes_mother-e-w, s(0,0,S,D,P,T,0), s(1,1,S,D,P,T,1)):-
    safe(s(1,1,S,D,P,T,1)).

move(farther_takes_daughter-w-e, s(1,M,S,1,P,T,1), s(0,M,S,D1,P,T,0)):-
    D>0,
    D1 is D-1,
    safe(s(0,M,S,D1,P,T,0)).

move(farther_takes_daughter-e-w, s(0,M,S,D,P,T,0), s(1,M,S,D1,P,T,1)):-
    D<2,
    D1 is D+1,
    safe(s(1,M,S,D1,P,T,1)).

move(mother-w-e, s(F,1,S,D,P,T,1), s(F,0,S,D,P,T,0)):-
    safe(s(F,0,S,D,P,T,0)).

move(mother-e-w, s(F,0,S,D,P,T,0), s(F,1,S,D,P,T,1)):-
    safe(s(F,1,S,D,P,T,1)).

move(mother_takes_son-w-e, s(F,1,1,D,P,T,1), s(F,0,S1,D,P,T,0)):-
    S>0,
    S1 is S-1,
    safe(s(F,0,S1,D,P,T,0)).

move(mother_takes_son-e-w, s(F,0,S,D,P,T,0), s(F,1,S1,D,P,T,1)):-
    S<2,
    S1 is S+1,
    safe(s(F,1,S1,D,P,T,1)).
