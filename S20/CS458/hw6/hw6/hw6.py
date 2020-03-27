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
    for x in states:  # initial step
        forward[0][x] = initial[x] * emissions[x][observations[0]]
    for x in range(1, len(observations)):  # recursion step
        forward.append({})
        for y in states:
            forward[x][y] = sum(forward[x-1][z] * transitions[z][y] *
                                emissions[y][observations[x]] for z in states)

    forwardprob = sum(forward[len(observations) - 1][x]
                      for x in states)  # termination step
    return forwardprob


observations = 'xzyyzzyzyy'
states = ['A', 'B']
symbols = ['x', 'y', 'z']
initial = {'A': 0.5, 'B': 0.5}
transitions = {
    'A': {'A': 0.303, 'B': 0.696},
    'B': {'A': 0.831, 'B': 0.169}
}
emissions = {'A': {'x': 0.533, 'y': 0.065, 'z': 0.402},
             'B': {'x': 0.342, 'y': 0.334, 'z': 0.324}
             }

print(forward(observations, states, initial, transitions, emissions))
