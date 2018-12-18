#!/usr/bin/env bash

echo "simulating datasets..."
python simulate_scenario_a.py

echo "running dystruct..."
export OMP_NUM_THREADS=2
for i in $(seq 10); do
    echo "run ${i}..."
    $1 --input scenario_a_genotypes_${i} \
       --generation-times scenario_a_times_${i} \
       --output A${i} \
       --npops 2 \
       --nloci 5000 \
       --pop-size 5000 \
       --seed 1145 \
       --hold-out-seed 55307 > scenario_a_${i}
done

echo "running admixture..."
for i in $(seq 10); do
    python format.py scenario_a_genotypes_${i}
    $2 scenario_a_genotypes_${i}.ped 3
done