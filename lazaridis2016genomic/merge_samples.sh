#!/usr/bin/env bash

python get_ho_autosomal_loci.py

cat NearEastPublic/unpacked_AncientLazaridis2016.pedsnp | sed "s/....$//g" > NearEastPublic/unpacked_AncientLazaridis2016.map
cat NearEastPublic/unpacked_HumanOriginsPublic2068.pedsnp | sed "s/....$//g" > NearEastPublic/unpacked_HumanOriginsPublic2068.map
plink --file NearEastPublic/unpacked_HumanOriginsPublic2068 \
      --noweb \
      --merge NearEastPublic/unpacked_AncientLazaridis2016.ped NearEastPublic/unpacked_AncientLazaridis2016.map \
      --recode \
      --extract NearEastPublic/ho-autosomes \
      --remove NearEastPublic/exclude_ind \
      --out humanorigins-lazaridis-merged