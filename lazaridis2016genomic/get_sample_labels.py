#!/usr/bin/env python

labels = {}
with open("NearEastPublic/AncientLazaridis2016.ind", "r") as f:
    for line in f:
        line = line.strip("\n").split()
        labels[line[0]] = line[2]

with open("NearEastPublic/HumanOriginsPublic2068.ind", "r") as f:
    for line in f:
        line = line.strip("\n").split()
        labels[line[0]] = line[2]

g = open("samplelabels-lazaridis2016genomic-ho", "w")
with open("lazaridis2016genomic-ho.ind", "r") as f:
    for line in f:
        line = line.strip("\n").split()
        g.write(labels[line[1]] + "\n")
g.close()
