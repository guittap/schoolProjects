def cuck(word):
    l = []
    for i in word:
        l.append(ord(i.upper()) - ord('A') + 1)
    h1 = (l[0] * 2 + l[1] * 4) % 7
    h2 = (h1 + (l[2] + l[3] * 5) % 6 + 1) % 7
    return h1, h2

print ("enter your dummy word: ", end="")
word = input()
print (cuck(word))

# for i in range(26):
#     for j in range(26):
#         for k in range(26):
#             for m in range(26):
#                 word = chr(i+ord('A')) + chr(j+ord('A')) + chr(k+ord('A')) + chr(m+ord('A'))
#                 h1, h2 = cuck(word)
#                 if h1 == h2:
#                     print(word)