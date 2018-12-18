import numpy as np


g = open("lazaridis2016genomic-ho.ind", "w")
with open("lazaridis2016genomic-ho.ped", "r") as f:
    for i,line in enumerate(f):
        ind = " ".join([str(i+1)] + line.split()[1:6])
        g.write(ind + "\n")
g.close()