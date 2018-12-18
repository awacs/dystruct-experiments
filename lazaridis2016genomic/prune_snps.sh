#!/usr/bin/env bash

plink --file humanorigins-lazaridis-merged \
      --noweb \
      --indep-pairwise 200 25 0.4

plink --file humanorigins-lazaridis-merged  \
      --noweb \
      --extract plink.prune.in \
      --recode12 \
      --out lazaridis2016genomic-ho
