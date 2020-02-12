# Wargen Guittap
# 5004493060 CS458 Assignment #2

# 1
import numpy as np
import matplotlib.pyplot as plt

# 2
# reads a list of numbers an normalize each item in the list using item - min / max - min


def min_max(list):
    returnList = []
    for i in list:
        returnList.append((i - min(list)) / (max(list) - min(list)))
    return returnList

# 3
# computes the total error for a given value of m and b. Use equation sum(y - y^)^2


def square_error(m, b, data):
    return sum([(data[i][1]-(m*data[i][0]+b))**2 for i in range(len(data))])

# 4
# a function gradient computes the gradients based on the partial derivatives and updates m and b with learning rate alpha derivatives


def gradient(m, b, data, alpha):
    D_b = sum([-1*(data[i][1]-(m*data[i][0]+b))
               for i in range(len(data))])
    D_m = sum([-1*(data[i][1]-(m*data[i][0]+b))*data[i][0]
               for i in range(len(data))])
    m = m - alpha * D_m
    b = b - alpha * D_b
    return m, b

# 5
# a function model reads the data, sets m and b randomly, sets alpha to 0.01, set iteration to 1000, runs gradient descent, and plots the points and regression line


def model():
    data = np.genfromtxt("datafile.txt", delimiter=',')

    x = min_max([data[i][0] for i in range(len(data))])
    y = min_max([data[i][1] for i in range(len(data))])
    data = [[x[i], y[i]] for i in range(len(data))]

    m, b = np.random.rand(2)
    iteration = 1000
    alpha = .01

    for i in range(iteration):
        print("iteration "+str(i+1)+": square error =", square_error(m, b, data))
        m, b = gradient(m, b, data, alpha)

    plt.plot(x, [m*x[i]+b for i in range(len(data))], "r")
    plt.plot(x, y, "go")
    plt.show()


if __name__ == '__main__':
    model()
