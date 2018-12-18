#!/usr/bin/env bash
#$ -pe smp 3 -l mem=4G,time=72:: -S /bin/bash -cwd

module load gcc/6.1.0

export OMP_NUM_THREADS=3

../bin/dystruct --input ../supp/lazaridis2016genomic/lazaridis2016genomic-ho.geno \
               --generation-times ../supp/lazaridis2016genomic/lazaridis2016genomic-sampletimes \
               --output lazaridis2016genomic-K3 \
               --npops 3 \
               --nloci 292849 \
               --pop-size 10000 \
               --seed 1145 \
               --hold-out-fraction 0.05
