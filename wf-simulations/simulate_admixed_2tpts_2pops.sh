#!/usr/bin/env bash

# admixed; generation time = 100; Ne = 2500
for i in $(seq 10); do
    mkdir data/admixed_100gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set admixed \
                       --sizes 2500 2500 \
                       --time-points 0 99 \
                       --samples 100 100
    mv freqs generations samples theta data/admixed_100gen_2500N_${i}/
done

# admixed; generation time = 200; Ne = 2500
for i in $(seq 10); do
    mkdir data/admixed_200gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set admixed \
                       --sizes 2500 2500 \
                       --time-points 0 199 \
                       --samples 100 100
    mv freqs generations samples theta data/admixed_200gen_2500N_${i}/
done

# admixed; generation time = 400; Ne = 2500
for i in $(seq 10); do
    mkdir data/admixed_400gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set admixed \
                       --sizes 2500 2500 \
                       --time-points 0 399 \
                       --samples 100 100
    mv freqs generations samples theta data/admixed_400gen_2500N_${i}/
done

# admixed; generation time = 800; Ne = 2500
for i in $(seq 10); do
    mkdir data/admixed_800gen_2500N_${i}
    python simulate.py -k 2 -l 10000 -s ${RANDOM} \
                       --set admixed \
                       --sizes 2500 2500 \
                       --time-points 0 799 \
                       --samples 100 100
    mv freqs generations samples theta data/admixed_800gen_2500N_${i}/
done