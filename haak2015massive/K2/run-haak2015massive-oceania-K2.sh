#!/usr/bin/env bash
#$ -pe smp 2 -l mem=4G,time=72:: -S /bin/bash -cwd

#module load gcc/6.1.0

export OMP_NUM_THREADS=2

../../dystruct/bin/dystruct --input ../data/haak2015massive-ancient-oceania.geno \
                            --generation-times ../data/haak2015massive-sampletimes-ancient-oceania \
                            --output haak2015massive-ancient-oceania-K2 \
                            --npops 2 \
                            --nloci 174984 \
                            --pop-size 10000 \
                            --seed 122056 \
			    --hold-out-fraction 0.05 
