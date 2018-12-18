#!/usr/bin/env bash

# merger; generation time = 100; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_100gen_2T_3POPS_2500N_${i}
    python simulate.py -k 3 -l 10000 -s ${RANDOM} \
                       --set merger3 \
                       --sizes 2500 2500 2500 \
                       --time-points 0 100 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_100gen_2T_3POPS_2500N_${i}/
done

# merger; generation time = 200; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_200gen_2T_3POPS_2500N_${i}
    python simulate.py -k 3 -l 10000 -s ${RANDOM} \
                       --set merger3 \
                       --sizes 2500 2500 2500 \
                       --time-points 0 200 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_200gen_2T_3POPS_2500N_${i}/
done

# merger; generation time = 400; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_400gen_2T_3POPS_2500N_${i}
    python simulate.py -k 3 -l 10000 -s ${RANDOM} \
                       --set merger3 \
                       --sizes 2500 2500 2500 \
                       --time-points 0 400 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_400gen_2T_3POPS_2500N_${i}/
done

# merger; generation time = 800; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_800gen_2T_3POPS_2500N_${i}
    python simulate.py -k 3 -l 10000 -s ${RANDOM} \
                       --set merger3 \
                       --sizes 2500 2500 2500 \
                       --time-points 0 800 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_800gen_2T_3POPS_2500N_${i}/
done