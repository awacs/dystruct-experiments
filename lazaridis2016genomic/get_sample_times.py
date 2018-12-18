#!/usr/bin/env python

import argparse
import numpy as np


generation_time = 25
min_year = 1E8
max_year = 0

sample_time = {}

with open("NearEastPublic/sample_table_tab_sep.txt", "r", encoding="windows-1252") as f:
    for line in f:
        if "Genetic ID" in line:
            continue
        line = line.strip("\n").split("\t")
        date_range = line[10].lstrip('"').split()
        if len(date_range) <= 1:
            continue
        date_range = date_range[0].split("-")
        date_range[0] = -float(date_range[0])
        date_range[1] = -float(date_range[1])
        time_yr = np.mean(date_range) # sample times are BCE, this centers year at 0
        min_year = time_yr if time_yr < min_year else min_year
        max_year = time_yr if time_yr > max_year else max_year
        sample_time[line[0]] = time_yr


time_years = []

with open("lazaridis2016genomic-ho.ind", "r") as f:
    for line in f:
        line = line.split()
        if line[1] in sample_time:
            time_years.append(sample_time[line[1]] - min_year)
        else:
            time_years.append( int(2017) - min_year )

time_gen = [ yr/generation_time for yr in time_years]
time_gen = np.array(time_gen)

bucket_size = 50
buckets = [[] for i in range(int(time_gen.max() / bucket_size))]
for idx,g in enumerate(time_gen):
    bucket_idx = int(g / bucket_size) 
    
    if g == time_gen.max():
        buckets[-1].append(g)
    elif g == 0:
        buckets[0].append(g)
    else:
        buckets[bucket_idx].append(g)

bucket_idx = 0
for idx,g in enumerate(time_gen):
    bucket_idx = int(g / bucket_size)

    if g == time_gen.max() or g == 0:
        continue
    else:
        time_gen[idx] = np.mean(buckets[bucket_idx])

np.savetxt("lazaridis2016genomic-sampletimes", time_gen, fmt="%i")
