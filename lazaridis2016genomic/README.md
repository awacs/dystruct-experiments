This folder contains scripts to rerun the analysis on the data from Lazaridis
et al.  (2015)'s "Genomic insights into the origin of farming in the ancient
Near East."

Because of the size of the dataset, it is not possible to provide preprocessed
files here. However, scripts to replicate the entire preprocessing pipeline
are available in this repository. First, download and extract the publicly available
dataset from the Reich lab website:

```
wget https://reich.hms.harvard.edu/sites/reich.hms.harvard.edu/files/inline-files/NearEastPublic.tar.gz
tar -xzvf NearEastPublic.tar.gz
```

Then, run the preprocessing pipeline using
```
./pipeline.sh
```
This will take several hours. Note that you can run the preprocessing steps one-at-a-time
following the same order as the pipeline script.

We recommend running DyStruct on this dataset on a computer cluster or
multicore machine, as results will take several days.  We used the scripts in
the jobscripts folder to submit jobs to an SGE cluster.
