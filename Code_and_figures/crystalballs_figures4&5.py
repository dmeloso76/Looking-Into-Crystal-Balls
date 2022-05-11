import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
from collections import Counter, defaultdict

df = pd.read_csv('evaluators_cluster.csv')
X = df[['avg_assOB','avg_assOO','avg_assBO_6','avg_assBO_8','avg_assBB_6','avg_assBB_8']]
X_nomissing = X.dropna()

sum_of_squared_distances = []
K = range(1,15)
for k in K:
    km = KMeans(n_clusters=k, init='k-means++', 
            max_iter=300, n_init=10, verbose=0, random_state=7718)
    km = km.fit(X_nomissing)
    sum_of_squared_distances.append(km.inertia_)
plt.plot(K, sum_of_squared_distances, 'bx-')
plt.xlabel('k')
plt.ylabel('Sum of Squared Distances')
plt.title('Elbow Method For Optimal k')
plt.show()

kmeans = KMeans(n_clusters=3, init='k-means++', 
            max_iter=300, n_init=10, verbose=0, random_state=7718)
kmeans.fit(X_nomissing)
labels = kmeans.predict(X_nomissing)
X_nomissing['clusters'] = labels
centroids = kmeans.cluster_centers_
print(centroids)
print(Counter(kmeans.labels_))
#print(labels)

#Figure 4: Evaluators’ Strategies Grouped in Clusters, Orange Report.

col = ['b', 'r','g']
lab = ['Bayesian Learners, Strong Reaction: 34% of Subjects',
       'Bayesian Learners, Mild Reaction: 29% of Subjects',
       'Non-Bayesian Learners: 37% of Subjects',
       ]       
mar = ['s',
       '*',
       "^"]
fig = plt.figure(figsize=(8,8))

for i in range(3):
    plt.scatter(X_nomissing[X_nomissing.clusters==i].avg_assOB, X_nomissing[X_nomissing.clusters==i].avg_assOO, c = 'white', marker = mar[i], edgecolors=  col[i],  s=30, alpha =.6, label = '_nolabel')
    plt.scatter(centroids[i,0], centroids[i,1], c = 'white', s=100, alpha =1, marker = mar[i], edgecolors=  col[i], linewidths = 2 , label = lab[i])

plt.xlabel('Average Assessment after O Report & B Core',fontsize = 12)
plt.ylabel('Average Assessment after O Report & O Core',fontsize = 12)
plt.axis([-5, 80, 20, 105])
plt.text(43, 90, 'Large symbols indicate center of the cluster ', fontsize = 8)
plt.legend(loc = 'best', fontsize = 'small')
plt.yticks([0, 25, 50, 75, 100])
plt.xticks([0, 25, 50, 75, 100])
plt.grid(True)
plt.show()
fig.savefig('figure_4')

# Figure 5(a): Evaluators’ Strategies Grouped in Clusters, Inaccurate Blue Report
col = ['b', 'r','g']
lab = ['Bayesian Learners, Strong Reaction: 34% of Subjects',
       'Bayesian Learners, Mild Reaction: 29% of Subjects',
       'Non-Bayesian Learners: 37% of Subjects',
       ]  
mar = ['s',
       '*',
       "^"]
fig = plt.figure(figsize=(8,8))

for i in range(3):
    plt.scatter(X_nomissing[X_nomissing.clusters==i].avg_assBO_6, X_nomissing[X_nomissing.clusters==i].avg_assBO_8, c = 'white', marker = mar[i], edgecolors=  col[i],  s=30, alpha =.6, label = '_nolabel')
    plt.scatter(centroids[i,2], centroids[i,3], c = 'white', s=100, alpha =1, marker = mar[i], edgecolors=  col[i], linewidths = 2 , label = lab[i])

plt.xlabel('Average Assessment after B Report & O Core with q=6',fontsize = 12)
plt.ylabel('Average Assessment after B Report & O Core with q=8',fontsize = 12)
plt.axis([-5, 105, -5, 105])
plt.text(43, 90, 'Large symbols indicate center of the cluster ', fontsize = 8)
plt.legend(loc = 'best', fontsize = 'small')
plt.yticks([0, 25, 50, 75, 100])
plt.xticks([0, 25, 50, 75, 100])
plt.grid(True)
plt.show()
fig.savefig('figure_5a')

# Figure 5(b): Evaluators’ Strategies Grouped in Clusters, Accurate Blue Report
col = ['b', 'r','g']
lab = ['Bayesian Learners, Strong Reaction: 34% of Subjects',
       'Bayesian Learners, Mild Reaction: 29% of Subjects',
       'Non-Bayesian Learners: 37% of Subjects',
       ]  
mar = ['s',
       '*',
       "^"]
fig = plt.figure(figsize=(8,8))

for i in range(3):
    plt.scatter(X_nomissing[X_nomissing.clusters==i].avg_assBB_6, X_nomissing[X_nomissing.clusters==i].avg_assBB_8, c = 'white', marker = mar[i], edgecolors=  col[i],  s=30, alpha =.6, label = '_nolabel')
    plt.scatter(centroids[i,4], centroids[i,5], c = 'white', s=100, alpha =1, marker = mar[i], edgecolors=  col[i], linewidths = 2 , label = lab[i])

plt.xlabel('Average Assessment after B Report & B Core with q=6',fontsize = 12)
plt.ylabel('Average Assessment after B Report & B Core with q=8',fontsize = 12)
plt.axis([-5, 105, -5, 105])
plt.text(43, 90, 'Large symbols indicate center of the cluster ', fontsize = 8)
plt.legend(loc = 'best', fontsize = 'small')
plt.yticks([0, 25, 50, 75, 100])
plt.xticks([0, 25, 50, 75, 100])
plt.grid(True)
plt.show()
fig.savefig('figure_5b')


