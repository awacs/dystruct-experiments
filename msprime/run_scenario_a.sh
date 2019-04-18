#!/usr/bin/env bash

MIXTURES=(0.125 0.25 0.375 0.5)

echo "simulating datasets..."
for mix in ${MIXTURES[@]}; do
    python simulate_scenario_a.py ${mix}
done

echo "running dystruct..."
export OMP_NUM_THREADS=2
K=(2 3)
for k in ${K[@]}; do
for mix in ${MIXTURES[@]}; do
for i in $(seq 10); do
    echo "run ${k} ${mix} ${i}..."
    $1 --input scenario_a_genotypes_${mix}_${i} \
       --generation-times scenario_a_times_${mix}_${i} \
       --output A_k${k}_${mix}_${i} \
       --npops ${k} \
       --nloci 10000 \
       --pop-size 5000 \
       --seed 1145 \
       --hold-out-seed 55307 \
       --epochs 50 \
       --hold-out-fraction 0.5 > scenario_a_k${k}_${mix}_${i}
done
done
done

K=(2 3)
for k in ${K[@]}; do
for mix in ${MIXTURES[@]}; do
echo "running admixture..."
for i in $(seq 10); do
    python format.py scenario_a_genotypes_${mix}_${i}
    ./admixture scenario_a_genotypes_${mix}_${i}.ped ${k}
done
done
done