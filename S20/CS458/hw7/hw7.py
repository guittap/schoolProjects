import re
import random

### reading file ###
f = open('Pride&Prejudice.txt', "r")
string = f.read().lower()
f.close()

### removing punctuation, numbers, or other special symbols ###
PUNCT = re.compile('[.,?1234567890;\'\"“:”()—!-]')
string = re.sub(PUNCT, " ", string)

### making possible typo diction ###
KEYS = list('qwerstyuiopasdfghjklzxcvbnm')
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

### creating noisy file with 10% character errors ###
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

### BUILDING HMM ###


### EXTRA CODE ###

## looking for stuff to remove ##
# stuffToRemove = set()
# for i in string:
#     if not i.isalpha():
#         stuffToRemove.add(i)

# print(stuffToRemove)

## making python print the basic dictionary for me because I am lazy ##
# print("keyboardArrangement = {")
# for i in KEYS:
#     print("\'"+i+"\': [\'\', \'\', \'\',],")

# checking dictionary
# print(keyboardArrangement)

