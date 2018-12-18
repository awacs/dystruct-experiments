#!/usr/bin/env python

# Converts sample files to .geno format for ADMIXTURE

import os
import numpy as np
from sys import argv

file = argv[1]
outfile = open(file + ".ped", "w")

genotypes = open(file, "r").readlines()
genotypes = [list(row.strip("\n")) for row in genotypes]
genotypes = np.array(genotypes).astype(int)

for row in genotypes.T:
    outfile.write("FAM001 0 0 0 0 0 ")
    genotypes = []
    for g in row:
        if g == 0:
            genotypes.append(1)
            genotypes.append(1)
        elif g == 1:
            genotypes.append(1)
            genotypes.append(2)
        else:
            genotypes.append(2)
            genotypes.append(2)
    outfile.write(" ".join([str(g) for g in genotypes]))
    outfile.write("\n")

