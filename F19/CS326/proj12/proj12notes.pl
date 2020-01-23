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

move(state(middle,onbox,middle,hasnot),
    grasp,
    state(middle,onbox,middle,has)).
move(state(P, onfloor, P, H),
    climb,
    state(P, onbox, P, H)).
move(state(P1, onfloor, P1, H),
    pushbox(P1,P2),
    state(P2, onfloor, P2, H)).
move(state(P1, onfloor, BP, H),
    walk(P1,P2),
    state(P2, onfloor, BP, H)).
getfood(state(_,_,_,has)).
getfood(S1) :-
    move(S1,_,S2),
    nl, write('In'), write(S1),
    nl, write('try'), write(_),
    nl,write('now'), write(S2),nl,
    getfood(S2).

%monkey and the banana problem
move(state(middle, middle, onbox, hasnot), %this is the grabbing state 
    grasp, %when the monkey in on the box and in the middle is will go for the banana
    state(middle, middle, onbox, has)).

move(state(MP, BP, onfloor, H), %this is the climb state
    climb, %at this state the monkey will go from on the floor to on the box
    state(MP, BP, onbox, H)).

move(state(P1, P1, onfloor, H), %this is the state of pushing the box
    pushbox(P1, P2), 
    state(P2, P2, onfloor, H)).

move(state(P1, BP, onfloor, H), %this is the walking state
    walk(P1,P2),
    state(P2, BP, onfloor, H)).

getfood(state(_,_,_,has)).
getfood(S1) :-
    move(S1,_,S2),
    nl, write('In '), write(S1),
    nl, write('try '), write(_),
    nl,write('now '), write(S2),nl,
    getfood(S2).