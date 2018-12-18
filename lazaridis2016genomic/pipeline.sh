#/usr/bin/env bash

./convert_to_ped.sh
./merge_samples.sh
./prune_snps.sh
./convert_to_geno.sh
./get_sample_times.py
./get_sample_labels.py
