#!/usr/bin/env bash

TIMES=(100 200 400 800)
for time in ${TIMES[@]}; do
for i in $(seq 10); do
    python format.py data/admixed_${time}gen_2T_3POPS_2500N_${i}/samples
    mv samples.ped data/admixed_${time}gen_2T_3POPS_2500N_${i}/
    $1 data/admixed_${time}gen_2T_3POPS_2500N_${i}/samples.ped 3
    mv samples.3.Q ./output/admixture/admixed_${time}gen_2T_3POPS_2500N_${i}.Q
    mv samples.3.P ./output/admixture/admixed_${time}gen_2T_3POPS_2500N_${i}.P
done
done

TIMES=(100 200 400 800)
for time in ${TIMES[@]}; do
for i in $(seq 10); do
    python format.py data/merger_${time}gen_2T_3POPS_2500N_${i}/samples
    mv samples.ped data/merger_${time}gen_2T_3POPS_2500N_${i}/
    $1 data/merger_${time}gen_2T_3POPS_2500N_${i}/samples.ped 3
    mv samples.3.Q ./output/admixture/merger_${time}gen_2T_3POPS_2500N_${i}.Q
    mv samples.3.P ./output/admixture/merger_${time}gen_2T_3POPS_2500N_${i}.P
done
done