# Wargen Guittap
# 5004493060 CS458 Assignment #6

#### standford forward algorithm ####
# function FORWARD(observations of len T, state-graph of len N) returns forward-prob
#   create a probability matrix forward[N,T]
#   for each state s from 1 to N do                         ; initialization step
#       forward[s,1] <- pi(s)* b(s)(o1)
#   for each time step t from 2 to T do                     ; recursion step
#       for each state s from 1 to N do
#           forward[s,t] <- sum (forward[s1,t-1] * A(s1,s) * B(s,o(t)) for s1 in state)
#   sum (foward[s,T] for s in state)                        ; termination step


def forward(observations, states, initial, transitions, emissions):
    forward = [{}]
    print("### ALPHA 1 ###")
    for x in states:  # initial step
        forward[0][x] = initial[x] * emissions[x][observations[0]]
        print("alpha 1 (state: " + x + ") = initial[x] * emissions[x][observations[0]]")
        print("alpha 1 (state: " + x + ") = " + str(initial[x]) + " * " + str(emissions[x][observations[0]]))
        print("alpha 1 (state: " + x + ") = " + str(forward[0][x]))
        print()

    for x in range(1, len(observations)):  # recursion step
        forward.append({})
        print("### ALPHA "+ str(x+1) +" ###")
        for y in states:
            print1 = "alpha 2 (state: " + y + ") = "
            print2 = "alpha 2 (state: " + y + ") = "
            recursion = []
            for z in states:
                recursion.append(forward[x-1][z] * transitions[z][y] * emissions[y][observations[x]])
                print2 += "(" + str(forward[x-1][z]) + " * " + str(transitions[z][y]) + " * " + str(emissions[y][observations[x]]) + ") + "

            print(print2[:-2])
            print(recursion)
            forward[x][y] = max(recursion)

        print(forward[x])
        print()

    forwardprob = sum(forward[len(observations) - 1][x]
                      for x in states)  # termination step
    return forwardprob


observations = 'UNUN'
states = ['Sunny', 'Rainy', 'Foggy']
symbols = ['U', 'N']
initial = {'Sunny': 0.33, 'Rainy': 0.33, 'Foggy': 0.33}
transitions = {
    'Sunny': {'Sunny': 0.8, 'Rainy': 0.05, 'Foggy': 0.15},
    'Rainy': {'Sunny': 0.2, 'Rainy': 0.6, 'Foggy': 0.2},
    'Foggy': {'Sunny': 0.2, 'Rainy': 0.3, 'Foggy': 0.5}
}
emissions = {'Sunny': {'U': 0.1, 'N': 0.9},
             'Rainy': {'U': 0.8, 'N': 0.2},
             'Foggy': {'U': 0.3, 'N': 0.7},
             }

print(forward(observations, states, initial, transitions, emissions))
