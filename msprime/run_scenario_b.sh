#!/usr/bin/env bash
echo "simulating datasets..."
python simulate_scenario_b.py

echo "running dystruct"
export OMP_NUM_THREADS=2
K=(2 4)
for k in ${K[@]}; do
for i in $(seq 10); do
    echo "run ${i}..."
    $1 --input scenario_b_genotypes_${i} \
       --generation-times scenario_b_times_${i} \
       --output B_k${k}_${i} \
       --npops ${k} \
       --nloci 10000 \
       --pop-size 5000 \
       --seed 3979 \
       --hold-out-seed 55307 \
       --hold-out-fraction 0.5 > scenario_b_k${k}_${i}
done
done

K=(2 3 4)
for k in ${K[@]}; do
echo "running admixture..."
for i in $(seq 10); do
    python format.py scenario_b_genotypes_${i}
    ./admixture scenario_b_genotypes_${i}.ped ${k}
done
done