# Wargen Guittap
# 5004493060 CS458 Assignment #8

import random
import numpy as np

### K_MEAN ##
def k_mean(points,k):
    #get k randomly chosen centers
    random.seed(100)
    centers = random.sample(points,k)
    clusters = []
    for c in centers:
        clusters.append(c)

    #iterate until centroids do not change
    done = False
    num_iterations = 0
    while not done:
        num_iterations +=1
        #create a list containing k distinct empty lists
        new_clusters = []
        for i in range(k):
            new_clusters.append([])
        #assign each point to the closest center
        for p in points:
            min_dist = np.linalg.norm(np.array(centers[0]) - np.array(p))
            index = 0
            for i in range(1,k):
                dist = np.linalg.norm(np.array(centers[i])- np.array(p))
                if dist < min_dist:
                    min_dist = dist
                    index = i

            # add p to the appropriate cluster
            new_clusters[index].append(p)

        #update each cluster, check if center has changed
        clusters = centers
        centers = []
        for x in new_clusters:
            centers.append(np.mean(x, axis = 0))

        done = np.array_equal(centers, clusters)

    return clusters

### READ INPUT ###
f = open("input.txt", "r")
input = f.read().split("\n")
k = int(input[0].split()[0])
m = int(input[0].split()[1])

points = []
for i in input[1:]:
    points.append(list(map(float,i.split(" "))))

print(k_mean(points, k))