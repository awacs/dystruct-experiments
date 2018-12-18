#!/usr/bin/env bash
export OMP_NUM_THREADS=2

SIZES=(1000 1250 2500 5000 10000)
TIMES=(100 200 400 800)
for time in ${TIMES[@]}; do
for i in $(seq 10); do
for size in ${SIZES[@]}; do
    echo "running admixed" ${i} "( time" ${time} "size" ${size} ")"
    ../../bin/dystruct --input data/admixed_${time}gen_2T_3POPS_2500N_${i}/samples \
                       --generation-times data/admixed_${time}gen_2T_3POPS_2500N_${i}/generations \
                       --output admixed_${time}gen_2T_3POPS_${size}N_${i} \
                       --npops 3 \
                       --nloci 10000 \
                       --pop-size ${size} \
                       --seed 1145 > admixed_${time}gen_2T_3POPS_${size}N_${i}
    mv admixed_${time}gen_2T_3POPS_${size}N_${i}_freqs admixed_${time}gen_2T_3POPS_${size}N_${i}_theta admixed_${time}gen_2T_3POPS_${size}N_${i} output/dystruct
done
done
done


for time in ${TIMES[@]}; do
for i in $(seq 10); do
for size in ${SIZES[@]}; do
    echo "running merger" ${i} "( time" ${time} "size" ${size} ")"
    ../../bin/dystruct --input data/merger_${time}gen_2T_3POPS_2500N_${i}/samples \
                       --generation-times data/merger_${time}gen_2T_3POPS_2500N_${i}/generations \
                       --output merger_${time}gen_2T_3POPS_${size}N_${i} \
                       --npops 3 \
                       --nloci 10000 \
                       --pop-size ${size} \
                       --seed 1145 > merger_${time}gen_2T_3POPS_${size}N_${i}
    mv merger_${time}gen_2T_3POPS_${size}N_${i}_freqs merger_${time}gen_2T_3POPS_${size}N_${i}_theta merger_${time}gen_2T_3POPS_${size}N_${i} output/dystruct
done
done
done