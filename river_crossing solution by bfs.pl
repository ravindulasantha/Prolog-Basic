initial_state(s(w, w, w, w)).
goal_state(s(e,e,e,e)).

opp(e, w).
opp(w, e).
equal(X,X).

unsafe(s(F, H, G, W)) :-
    opp(F, H),
    (   equal(H, G) ;   
        equal(H, W)).

safe(S) :- not(unsafe(S)).

move(s(S,H, G, W), s(S1, H, G, W), A):-
    opp(S, S1),
    safe(s(S1, H, G, W)),
    A='Farmer rows alone from'-S-to-S1.

move(s(S,S, G, W), s(S1, S1, G, W), A):-
    opp(S, S1),
    safe(s(S1, S1, G, W)),
    A='Farmer takes Hen from'-S-to-S1.

move(s(S,H, S, W), s(S1, H, S1, W), A):-
    opp(S, S1),
    safe(s(S1, H, S1, W)),
    A='Farmer takes Grain from'-S-to-S1.

move(s(S,H, G, S), s(S1, H, G, S1), A):-
    opp(S, S1),
    safe(s(S1, H, G, S1)),
    A='Farmer takes Wolf from'-S-to-S1.

children(Cs, Nss):-
    bagof(Ns, A^move(Cs, Ns, A), Nss).

bfs([Path|_Other_Paths], Gs, FP):-
    equal(Path, [Gs|_]),
    reverse(Path, FP).

bfs([Path|Other_paths], Gs, FP):-
    equal(Path, [Gs|_]),
    bfs(Other_paths, Gs, FP).

bfs([Path|Other_paths], Gs, FP):-
    equal(Path, [Cs|_P]), not(equal(Cs, Gs)),
    extend_path(Path, Paths),
    append(Other_paths, Paths, New_paths),
    bfs(New_paths, Gs, FP).

extend_path([Cs|RPath],Extndd_paths):-
    children(Cs, LCs),!,
    extnd_pth(LCs, [Cs|RPath], [], Extndd_paths).
extend_path(_, []).

extnd_pth([C|RLcs], Path, Paths,  Extndd_paths):-
    (   not(member(C, Path))->
    append(Paths, [[C|Path]], Extended_paths_C); equal(Extended_paths_C, Paths)),
    extnd_pth(RLcs, Path, Extended_paths_C, Extndd_paths).
extnd_pth([],_,P, P).

write_actions([S1, S2 | Rest]):-
  move(S1, S2, A12),
  writeln(A12),
  write_actions([S2 |Rest]).
write_actions([_]).

solve_by_bfs(Is, Gs, Path):-
    bfs([[Is]], Gs, Path), write_actions(Path).