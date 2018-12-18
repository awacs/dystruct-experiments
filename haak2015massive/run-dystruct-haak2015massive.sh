#!/usr/bin/env bash
export OMP_NUM_THREADS=2

$1 --input ./data/haak2015massive-ancient-europe.geno \
   --generation-times ./data/haak2015massive/haak2015massive-sampletimes-ancient-europe \
   --output haak2015massive-ancient-europe-K3 \
   --npops 3 \
   --nloci 149104 \
   --pop-size 10000 \
   --seed 1145 \
   --epochs 50 \
   --hold-out-fraction 0.05


$1 --input ./data/haak2015massive-ancient-oceania.geno \
   --generation-times ./data/haak2015massive-sampletimes-ancient-oceania \
   --output haak2015massive-ancient-oceania-K3 \
   --npops 3 \
   --nloci 174984 \
   --pop-size 10000 \
   --seed 1145 \
   --epochs 50 \
   --hold-out-fraction 0.05
