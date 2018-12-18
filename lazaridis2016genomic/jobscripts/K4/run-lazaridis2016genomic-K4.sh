#!/usr/bin/env bash
#$ -pe smp 4 -l mem=4G,time=72:: -S /bin/bash -cwd

module load gcc/6.1.0

export OMP_NUM_THREADS=4

../bin/dystruct --input ../supp/lazaridis2016genomic/lazaridis2016genomic-ho.geno \
               --generation-times ../supp/lazaridis2016genomic/lazaridis2016genomic-sampletimes \
               --output lazaridis2016genomic-K4 \
               --npops 4 \
               --nloci 292849 \
               --pop-size 10000 \
               --seed 1145 \
               --hold-out-fraction 0.05
