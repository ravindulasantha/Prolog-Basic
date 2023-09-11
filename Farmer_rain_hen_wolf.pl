initial_state(s(w,w,w,w)).
goal_state(s(e,e,e,e)).

equal(X,X).
unequal(X,Y):-not(equal(X,Y)).

opp(S1, S2) :- unequal(S1,S2).
opp(e,w).

unsafe(s(F,G,H,W)):-
    unequal(F,H),
    (   equal(G,H);
    	equal(H,W)).
safe(S) :- not(unsafe(S)).

move(a1-w-e, s(w, G, H, W), s(e, G, H, W)):-
    safe(s(e, G, H, W)).
move(a2-w-e, s(w, w, H, W), s(e, e, H, W)):-
    safe(s(e, e, H, W)).
move(a3-w-e, s(w, G, w, W), s(e, G, e, W)):-
    safe(s(e, G, e, W)).
move(a4-w-e, s(w, G, H, w), s(e, G, H, e)):-
    safe(s(e, G, H, e)).

move(a5-e-w, s(e, G, H, W), s(w, G, H, W)):-
    safe(s(w, G, H, W)).
move(a6-e-w, s(e, e, H, W), s(w, w, H, W)):-
    safe(s(w, w, H, W)).
move(a7-e-w, s(e, G, e, W), s(w, G, w, W)):-
    safe(s(w, G, w, W)).
move(a8-e-w, s(e, G, H, e), s(w, G, H, w)):-
    safe(s(w, G, H, w)).

find_path(GS, GS, Pathsofar, Path) :-
	reverse(Pathsofar, Path).

find_path(CS, GS, Pathsofar, Path) :-
	move(A1, CS, NS),
	not(member(NS-_X, Pathsofar)),
	find_path(NS, GS, [CS-A1|Pathsofar], Path).

action(A-D1-D2):-
    (A=a1; A=a5),
    format("Farmer rows along from ~s to ~s ~n",[D1,D2]).
action(A-D1-D2):-
    (A=a2; A=a6),
    format("Farmer takes ~s from ~s to ~s ~n",[grain, D1,D2]).
action(A-D1-D2):-
    (A=a3; A=a7),
    format("Farmer takes ~s from ~s to ~s ~n",[hen, D1,D2]).
action(A-D1-D2):-
    (A=a4; A=a8), 
    desc(D1, LD1), desc(D2, LD2),
    format("Farmer takes ~s from ~s to ~s ~n",[wolf, LD1,LD2]).

desc(w, west).
desc(e, east).