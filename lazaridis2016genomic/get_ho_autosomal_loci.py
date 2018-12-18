#!/usr/bin/env python


# HO.snp is the list of snps used to compare ancient and
# modern samples in Lazaridis et al. (2016). See
# NearEastPublic/README for more details.

g = open("NearEastPublic/ho-autosomes", "w")
with open("NearEastPublic/HO.snp", "r") as f:
    for line in f:
        row = line.split()
        if row[1] == "23" or row[1] == "24":
            continue
        g.write(row[0] + "\n")
g.close()