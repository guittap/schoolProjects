import matplotlib.pyplot as p
data = open(r"myData.txt", "r")
x = [int(line.split(",")[0]) for line in data]
y = [int(line.split(",")[1]) for line in data]
length = len(x)
slope = ((sum(y)/length) - (sum([x[i]*y[i] for i in range(length)])/length) / (sum(x)/length)) / (
    (sum(x)/length) - (sum([x[i]**2 for i in range(length)])/length) / (sum(x)/length))
yIntercept = (sum(y)/length) - slope * (sum(x)/length)
p.plot([min(x), max(x)], [slope*min(x) + yIntercept, slope*max(x)+yIntercept])
p.plot(x, y, "o")
p.show()
