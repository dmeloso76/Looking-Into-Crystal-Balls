import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.read_csv('evaluators_boxplots.csv')

# Figure 3: Evaluators’ Assessments by Observed Report-Core Pair and Treatment.
fig = plt.figure(figsize=(10, 8))
sns.set_style("whitegrid")
g = sns.boxplot(x="report_core", y="assessment", hue="q", data=df, palette="Set1",order=['BB','BO','OB','OO'])
plt.ylabel("Assessment",fontsize=14)
plt.xlabel("Observed Report and Core",fontsize=14)
g.set(xticklabels=["B Report & b Core", "B Report & o Core", "O Report & b Core", "O Report & o Core"])
# plt.show(g)
fig.savefig('figure_3')

