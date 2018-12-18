#!/usr/bin/env bash

FOLDER="NearEastPublic"
INFILEPRE="AncientLazaridis2016"
PARFILE=par.PACKEDANCESTRYMAP.PED

echo "genotypename:    ${FOLDER}/${INFILEPRE}.geno" > ${PARFILE}
echo "snpname:         ${FOLDER}/${INFILEPRE}.snp" >> ${PARFILE}
echo "indivname:       ${FOLDER}/${INFILEPRE}.ind" >> ${PARFILE}
echo "outputformat:    PED" >> ${PARFILE}
echo "genotypeoutname: ${FOLDER}/unpacked_${INFILEPRE}.ped" >> ${PARFILE}
echo "snpoutname:      ${FOLDER}/unpacked_${INFILEPRE}.pedsnp" >> ${PARFILE}
echo "indivoutname:    ${FOLDER}/unpacked_${INFILEPRE}.pedind" >> ${PARFILE}

./convertf -p ${PARFILE}


FOLDER="NearEastPublic"
INFILEPRE="HumanOriginsPublic2068"
PARFILE=par.PACKEDANCESTRYMAP.PED

echo "genotypename:    ${FOLDER}/${INFILEPRE}.geno" > ${PARFILE}
echo "snpname:         ${FOLDER}/${INFILEPRE}.snp" >> ${PARFILE}
echo "indivname:       ${FOLDER}/${INFILEPRE}.ind" >> ${PARFILE}
echo "outputformat:    PED" >> ${PARFILE}
echo "genotypeoutname: ${FOLDER}/unpacked_${INFILEPRE}.ped" >> ${PARFILE}
echo "snpoutname:      ${FOLDER}/unpacked_${INFILEPRE}.pedsnp" >> ${PARFILE}
echo "indivoutname:    ${FOLDER}/unpacked_${INFILEPRE}.pedind" >> ${PARFILE}

./convertf -p ${PARFILE}