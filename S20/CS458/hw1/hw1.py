# Homework 1 CS458
# Wargen Guittap
# 5004493060
import matplotlib.pyplot as plt

# A
# parsing through the files
# replaces any end lines with empty strings
# splits each line by comma and converting it to int
data = open(r"myData.txt", "r")
x = []
y = []
for line in data:
    line.replace("\n", "")
    x.append(int(line.split(",")[0]))
    y.append(int(line.split(",")[1]))

# B
# solving for linear regression
# find the length of the data set
# find the slope of the dataset
# find the yIntercept of the dataset
length = len(x)
slope = ((sum(y)/length) - (sum([x[i]*y[i] for i in range(length)])/length) / (sum(x)/length)) / (
    (sum(x)/length) - (sum([x[i]**2 for i in range(length)])/length) / (sum(x)/length))
yIntercept = (sum(y)/length) - slope * (sum(x)/length)

# C
# print slope and y-intercept and then plot the regression line and points
# prints slope and y-intercept with proper titles
# plots the linear regression using the minimum x and maximum x
# plots all x and y
print("slope of the linear regression is:", slope)
print("y-intercept of the linear regression is:", yIntercept)
plt.plot([min(x), max(x)], [slope*min(x) +
                            yIntercept, slope*max(x)+yIntercept], "r")
plt.plot(x, y, "go")
plt.show()

data.close()
