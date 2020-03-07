import numpy as np
import matplotlib.pyplot as plt

a = np.random.rand(10)
b = np.random.rand(3, 2)
c = np.linspace(50.0, 80.0, 20)

x_1 = [68, 69, 78.5, 75, 5]
y_1 = [66.5, 72.1, 75.3, 79.2]
plt.axis([60, 85, 60, 85])
plt.plot(x_1, y_1, 'ro')

plt.show()
t = np.linspace(60, 85, 20)
