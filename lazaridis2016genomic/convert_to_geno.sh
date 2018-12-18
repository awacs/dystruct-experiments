#!/usr/bin/env bash

INFILEPRE="lazaridis2016genomic-ho"
PARFILE=par.PED.EIGENSTRAT

python make_ind_file.py

echo "genotypename:    ${INFILEPRE}.ped" > ${PARFILE}
echo "snpname:         ${INFILEPRE}.map" >> ${PARFILE}
echo "indivname:       ${INFILEPRE}.ind" >> ${PARFILE}
echo "outputformat:    EIGENSTRAT" >> ${PARFILE}
echo "genotypeoutname: ${INFILEPRE}.geno" >> ${PARFILE}
echo "snpoutname:      ${INFILEPRE}.genosnp" >> ${PARFILE}
echo "indivoutname:    ${INFILEPRE}.genoind" >> ${PARFILE}

./convertf -p ${PARFILE}
