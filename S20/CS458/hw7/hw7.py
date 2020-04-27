# Wargen Guittap
# 5004493060 CS458 Assignment #7

import re
import random
from hmmlearn import hmm
import numpy as np
from sklearn.model_selection import train_test_split

### reading file ###
def readFile():
    f = open('Pride&Prejudice.txt', "r")
    string = f.read().lower()
    f.close()
    return string

### removing punctuation, numbers, or other special symbols ###
def cleanString(string):
    PUNCT = re.compile('[.,?1234567890;\'\"“:”()—!-]')
    string = re.sub(PUNCT, " ", string)
    f = open("clean.txt", "w")
    f.write(string)
    f.close()
    return string

### making possible typo diction ###
def keysAndArrange():
    KEYS = list('qwertyuiopasdfghjklzxcvbnm')
    keyboardArrangement = {
        'q': ['w', 's', 'a',],
        'w': ['q', 'e', 's',],
        'e': ['w', 'd', 'r',],
        'r': ['e', 'f', 't',],
        't': ['r', 'g', 'y',],
        'y': ['t', 'h', 'u',],
        'u': ['y', 'j', 'i',],
        'i': ['u', 'k', 'o',],
        'o': ['i', 'l', 'p',],
        'p': ['i', 'o', 'l',],
        'a': ['q', 's', 'z',],
        's': ['a', 'w', 'd',],
        'd': ['s', 'e', 'f',],
        'f': ['d', 'r', 'g',],
        'g': ['f', 't', 'h',],
        'h': ['g', 'y', 'j',],
        'j': ['h', 'u', 'k',],
        'k': ['j', 'i', 'l',],
        'l': ['k', 'o', 'p',],
        'z': ['a', 's', 'x',],
        'x': ['s', 'd', 'c',],
        'c': ['d', 'f', 'v',],
        'v': ['f', 'g', 'b',],
        'b': ['g', 'h', 'n',],
        'n': ['h', 'j', 'm',],
        'm': ['n', 'j', 'k',]
    }
    return KEYS, keyboardArrangement

### creating noisy file with 10% character errors ###
def noisyFileCreator(string, keyboardArrangement):
    count = 0
    total = 0
    f = open('noisy.txt', "w")
    random.seed(20)
    for i in string:
        r = random.randint(1,10)
        if i.isalpha():
            if r==1:
                r = random.randint(0, 2)
                f.write(keyboardArrangement[i][r])
                count +=1
            else: 
                f.write(i)
            
            total +=1
        else:
            f.write(i)

    print (count/total)
    f.close()

### splitting data ###
def split_data(X, y):
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.20, random_state=42)

    return X_train, X_test, y_train, y_test

def vEmissions(KEYS, keyboardArrangement):
    emissions = []
    for i in range(26):
        emissions.append([])
        for j in range(26):
            emissions[i].append(0)
            if KEYS[j] in keyboardArrangement[KEYS[i]]:
                emissions[i][j] = (1/3)*(1/10)

            if KEYS[j] == KEYS[i]:
                emissions[i][j] = 9/10

    return(np.array(emissions))

def vTransitions(X_train, KEYS):
    transitions = []
    for i in range(26):
        transitions.append([])
        for j in range(26):
            transitions[i].append(0)

    for i in X_train:
        for j in range(len(i)-1):
            transitions[KEYS.index(i[j])][KEYS.index(i[j+1])] += 1

    for i in range(26):
        total = sum(transitions[i])
        for j in range(26):
            transitions[i][j] /= total

    return(np.array(transitions))


### Viterbie ###
def viterbie(KEYS, model, y_test):
    f = open("result.txt", "w")
    for i in y_test:
        try:
            if i.isalpha():
                test1 = [KEYS.index(i) for i in list(i)]

                test1 = np.array([test1]).T
                model1 = model.fit(test1)
                logprob, result1 = model.decode(test1, algorithm="viterbi")

                result1 = "".join(KEYS[j] for j in result1)

                f.write(result1)
            
            else: 
                f.write(i)

        except:
            print("did not work!")
    f.close()

def main():
    ## READ FILE ##
    string = readFile()

    ## CLEAN TEXT ##
    string = cleanString(string)

    ## Keys definition and keyboard arrangement ## 
    KEYS, keyboardArrangement = keysAndArrange()

    ## NOISY FILE ##
    noisyFileCreator(string, keyboardArrangement)

    ## SPLIT DATA ##
    clean = string.split()
    noisy = open("noisy.txt", "r").read().split()
    X_train, X_test, y_train, y_test = split_data(clean, noisy)

    ## CREATING HMM MODEL##
    states = KEYS
    symbols = KEYS
    initial = np.array([1/26 for i in states])
    model = hmm.MultinomialHMM(n_components=len(KEYS))
    model.startprob = initial
    model.transmat = vTransitions(X_train, KEYS)
    model.emissionprob = vEmissions(KEYS, keyboardArrangement)

    ## VITERBIE ##
    viterbie(KEYS, model, y_test)

if __name__ == '__main__':
    main()
