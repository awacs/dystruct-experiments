This folder contains scripts to replicate the Wright-Fisher simulations.
The following scripts simulated data under the scenarios described in the
paper:
```
./simulate_admixed_2tpts_2pops.sh
./simulate_admixed_2tpts_3pops.sh
./simulate_admixed_5tpts_5pops.sh
./simulate_merger_2tpts_2pops.sh
./simulate_merger_2tpts_3pops.sh
./simulate_merger_5tpts_5pops.sh
```

The script `simulate.py` contains the actual simulation code. The following
scripts run DyStruct and ADMIXTURE respectively.

```
run_admixture_2tpts_2pops.sh PATH-TO-ADMIXTURE
run_admixture_2tpts_3pops.sh PATH-TO-ADMIXTURE
run_admixture_5tpts_2pops.sh PATH-TO-ADMIXTURE
run_dystruct_2tpts_2pops.sh PATH-TO-DYSTRUCT
run_dystruct_2tpts_3pops.sh PATH-TO-DYSTRUCT
run_dystruct_5tpts_2pops.sh PATH-TO-DYSTRUCT
```
