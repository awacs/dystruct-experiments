#!/usr/bin/env bash

TIMES=(100 200 400 800)
for time in ${TIMES[@]}; do
for i in $(seq 10); do
    python format.py data/admixed_${time}gen_2500N_${i}/samples
    mv samples.ped data/admixed_${time}gen_2500N_${i}/
    $1 data/admixed_${time}gen_2500N_${i}/samples.ped 2
    mv samples.2.Q ./output/admixture/admixed_${time}gen_2500N_${i}.Q
    mv samples.2.P ./output/admixture/admixed_${time}gen_2500N_${i}.P
done
done

TIMES=(100 200 400 800)
for time in ${TIMES[@]}; do
for i in $(seq 10); do
    python format.py data/merger_${time}gen_2500N_${i}/samples
    mv samples.ped data/merger_${time}gen_2500N_${i}/
    $1 data/merger_${time}gen_2500N_${i}/samples.ped 2
    mv samples.2.Q ./output/admixture/merger_${time}gen_2500N_${i}.Q
    mv samples.2.P ./output/admixture/merger_${time}gen_2500N_${i}.P
done
done