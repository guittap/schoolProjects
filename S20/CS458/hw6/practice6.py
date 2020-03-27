def fwd(observations, states, start_prob, trans_prob, emm_prob, end_st):
    fwd = []
    f_prev = {}
    for i, observation_i in enumerate(observations):
        f_curr = {}
        for st in states:
            if i == 0:
                prev_f_sum = start_prob[st]
            else:
                prev_f_sum = sum(f_prev[k]*trans_prob[k][st] for k in states)

            f_curr[st] = emm_prob[st][observation_i] * prev_f_sum

        fwd.append(f_curr)
        f_prev = f_curr

    p_fwd = sum(f_curr[k] * trans_prob[k][end_st] for k in states)
    return fwd


states = ['A', 'B']
endState = 'e'

initial = {'A': 0.5, 'B': 0.5}

transitions = {
    'A': {'A': 0.303, 'B': 0.696, 'e': 0.001},
    'B': {'A': 0.831, 'B': 0.169, 'e': 0.001},
}

emissions = {'A': {'x': 0.533, 'y': 0.065, 'z': 0.402},
             'B': {'x': 0.342, 'y': 0.334, 'z': 0.324}
             }

sequence = ['x', 'z', 'y', 'y', 'z', 'z', 'y', 'z', 'y', 'y']
print(sum(fwd(sequence, states, initial, transitions,
              emissions, endState)[len(sequence)-1].values()))
