#!/usr/bin/env bash

# merger; generation time = 100; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_100gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set merger \
                       --sizes 2500 2500 \
                       --time-points 0 99 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_100gen_2500N_${i}/
done

# merger; generation time = 200; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_200gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set merger \
                       --sizes 2500 2500 \
                       --time-points 0 199 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_200gen_2500N_${i}/
done

# merger; generation time = 400; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_400gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set merger \
                       --sizes 2500 2500 \
                       --time-points 0 399 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_400gen_2500N_${i}/
done

# merger; generation time = 800; Ne = 2500
for i in $(seq 10); do
    mkdir data/merger_800gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set merger \
                       --sizes 2500 2500 \
                       --time-points 0 799 \
                       --samples 100 100
    mv freqs generations samples theta data/merger_800gen_2500N_${i}/
done