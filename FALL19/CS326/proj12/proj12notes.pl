speed(ford, 100).
speed(chevy, 105).
speed(dodge, 95).
speed(volvo, 80).
time(ford, 20).
time(chevy, 21).
time(dodge, 24).
time(volve, 24).

distance :- speed(X, speed),

perform (grasp,
    state(middle, middle, on box, has not)).
perform (climb,
    state(MP, BP, onfloor, H)).
perform (pushbox,
    state(P1, P1, onfloor,H)).
perform (walk,
    state(P1, BP, onfloor, H)),
    state(P2, BP, onfloor, H).
getfood(state(_,_,_,has)).
getfood(S1) :-
    perform(Act, S1, S2),
    n1, write('In'), write(S1),
    n1, write('try'), write(Act),
    n1,write('now'), write(S2),n1,
    getfood(S2).
