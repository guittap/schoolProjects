%find the speed of the cars
car(ford,chevy,dodge,volvo).

speed(ford,100).
speed(chevy,105).
speed(dodge,95).
speed(volvo,80).

time(ford,20).
time(chevy,21).
time(dodge,24).
time(volvo,24).

distance(X) :-
	speed(X,Speed), 
    time(X,Time),
    Y is Speed * Time,
	write('Distance traveled by '),
	write(X),
	write(' was '),
	write(Y),nl.

distanceAll :- distance(ford),distance(chevy),distance(dodge),distance(volvo).

%find all icecream combinations
flavor(strawberry).
flavor(chocolate).
flavor(vanilla).
sundae(X, Y, Z):-
    flavor(X), 
    flavor(Y),
	flavor(Z),
    write(X + Y + Z),
    nl,fail. %fail will look for other alternative options

findIceCreamCombinations :- sundae(Top,Middle,Bottom).

%monkey and the banana problem

move(grasp,                                 %this is the grabbing state 
    state(middle, middle, onbox, hasnot),   %when the monkey in on the box and in the middle is will go for the banana
    state(middle, middle, onbox, has)).

move(climb,                                 %this is the climb state
    state(MP, BP, onfloor, H),              %at this state the monkey will go from on the floor to on the box
    state(MP, BP, onbox, H)).

move(pushbox(P1, P2),                       %this is the state of pushing the box
    state(P1, P1, onfloor, H), 
    state(P2, P2, onfloor, H)).

move(walk(P1,P2),                           %this is the walking state
    state(P1, BP, onfloor, H), 
    state(P2, BP, onfloor, H)).

getfood(state(_,_,_,has)).
getfood(S1) :-
    move(Act,S1,S2),
    nl, write('In '), write(S1),
    nl, write('try '), write(Act),
    nl,write('now '), write(S2),nl,
    getfood(S2).