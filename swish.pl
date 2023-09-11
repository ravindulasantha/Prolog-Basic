country(sri-lanka).
country('Sri Lanka').
country(india).

capital(sri-lanka, sjp).
capital(india, new-delgi).
capital(pakistan, islambad).
capital(singapore, singapore).
capital(bangladesh, dhaka).
capital(nepal, kathmandu).

likes(john, mary).
likes(john, ravi).
likes(john, pamela).
likes(mary, ravi).
likes(pamela, john).

friends(P1, P2) :- likes(P1, P2), likes(P2, P1).
