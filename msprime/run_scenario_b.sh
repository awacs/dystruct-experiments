#!/usr/bin/env bash
echo "simulating datasets..."
python simulate_scenario_b.py

echo "running dystruct"
export OMP_NUM_THREADS=2
for i in $(seq 10); do
    echo "run ${i}..."
    $1 --input scenario_b_genotypes_${i} \
       --generation-times scenario_b_times_${i} \
       --output B${i} \
       --npops 3 \
       --nloci 5000 \
       --pop-size 5000 \
       --seed 3979 \
       --hold-out-seed 55307 > scenario_b_${i}
done

echo "running admixture..."
for i in $(seq 10); do
    python format.py scenario_b_genotypes_${i}
    $2 scenario_b_genotypes_${i}.ped 3
done