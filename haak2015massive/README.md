This folder contains scripts to rerun the analysis on the data from Haak et al.
(2015)'s "Massive migration from the steppe was a source for Indo-European
languages in Europe." Preprocessed data to provide as input to DyStruct and
ADMIXTURE are available in the compressed archive data.tar.gz.  The analyses
can be rerun with the following scripts:

./run-dystruct-haak2015massive.sh PATH-TO-DYSTRUCT
./run-admixture-haak2015massive.sh PATH-TO-ADMIXTURE

The following files are output:
- haak2015massive-ancient-europe-K3_theta : DyStruct's ancestry estimates for the West Eurasian dataset
- haak2015massive-ancient-europe-K3_freqs : DyStruct's allele frequency estimates for the West Eurasian dataset
- haak2015massive-ancient-oceania-K3_theta : DyStruct's ancestry estimates for the Oceanian dataset
- haak2015massive-ancient-oceania-K3_freqs : DyStruct's allele frequency estimates for the Oceanian dataset
- haak2015massive-ancient-europe.3.Q : ADMIXTURE's ancestry estimates for the West Eurasian dataset
- haak2015massive-ancient-europe.3.P : ADMIXTURE's allele frequency estimates for the West Eurasian dataset
- haak2015massive-ancient-oceania.3.Q : ADMIXTURE's ancestry estimates on the Oceanian dataset
- haak2015massive-ancient-oceania.3.Q : ADMIXTURE's allele frequency estimates for the Oceanian dataset
