same(X, X).
diff(X, Y):- not(same(X, Y)).

genList(N, List):-
    genList(N, [], List).
genList(N, ListSofar, NewList):-
    N > 0, 
	N1 is N-1, 
    genList(N1, [N|ListSofar], NewList).
genList(0, List, List).

select(H,[H|T],T).
select(H,[H1|T1],[H1|Rest1]):-
      select(H,T1,Rest1).
      
unsafe_queens(q(R1, C1), q(R2, C2)):-
    same(R1, R2);
    same(C1, C2);
    ( 	Rdiff is abs(R1 - R2),Cdiff is abs(C1 - C2),same(Rdiff, Cdiff) ).
safe_queens(Q1, Q2) :-
    not(unsafe_queens(Q1,Q2)).

/*Check whether Q is safe with the Queens already placed*/
safe_queens_list(Q, [Q1|QueensList]):-
	safe_queens(Q, Q1), 
    safe_queens_list(Q, QueensList).
safe_queens_list(_, []).

place_queens(R, N, Cols, RemainingCols, BoardSofar, NewBoard):-
    R < N, select(C1, Cols, Cols1), 
    R1 is R + 1, 
    safe_queens_list(q(R1,C1), BoardSofar),
    place_queens(R1, N, Cols1, RemainingCols, [q(R1,C1)|BoardSofar], NewBoard).
place_queens(N, N, _, _, QueensBoard, QueensBoard).

/*Make a query to obtain a board of N queens */
nqueens(N, Board):-
    genList(N, Cols), 
    place_queens(0, N, Cols, _, [], RevBoard),
    reverse(RevBoard, Board).