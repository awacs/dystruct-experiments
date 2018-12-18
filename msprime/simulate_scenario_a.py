import msprime
import numpy as np

def simulate_scenario_a(nloci):
    """Simulate haploid individuals under historical admixture.
    Three populations merge 200 generations ago. Ancient samples are
    from three populations prior to mixture. Modern samples are from
    after admixture event.
    """

    Ne = 5000
    ancestral_Ne = 2500
    time_merge = 200
    time_split = 3000

    samples = [msprime.Sample(population=0, time=0) for i in range(200)] + \
              [msprime.Sample(population=0, time=time_merge+10) for i in range(100)] + \
              [msprime.Sample(population=1, time=time_merge+10) for i in range(100)]

    pop0 = msprime.PopulationConfiguration(initial_size=Ne)
    pop1 = msprime.PopulationConfiguration(initial_size=Ne)

    population_configurations = [
        pop0,
        pop1
    ]

    demographic_events = [

        # Admixture event at time_merge
        msprime.MassMigration(time=time_merge, source=0, destination=1, proportion=0.25),

        # Size change
        msprime.PopulationParametersChange(time=time_merge, initial_size=ancestral_Ne, population_id=0),
        msprime.PopulationParametersChange(time=time_merge, initial_size=ancestral_Ne, population_id=1),

        # Split
        msprime.MassMigration(time=time_split, source=0, destination=1, proportion=1.)
    ]

    #dd = msprime.DemographyDebugger(
    #    population_configurations=population_configurations,
    #    demographic_events=demographic_events)
    #dd.print_history()
    #exit()
    #tree_sequence = msprime.simulate(samples=samples,
    #                                 population_configurations=population_configurations,
    #                                 demographic_events=demographic_events,
    #                                 mutation_rate=1e-8,
    #                                 recombination_rate=1e-4,
    #                                 length=1e8)

    genotypes = np.zeros((nloci, 400))
    i = 0
    while i < nloci:
        tree_sequence = msprime.simulate(samples=samples,
                                 population_configurations=population_configurations,
                                 demographic_events=demographic_events,
                                 mutation_rate=1e-8,
                                 recombination_rate=0,
                                 length=1e3)
        sim_genotypes = tree_sequence.genotype_matrix()
        if sim_genotypes.size == 0:
            continue

        # SNPs x allele genotype matrix
        apop0_means = sim_genotypes[:,200:300].mean(axis=1)
        apop0_keep = np.logical_and(apop0_means > 0, apop0_means < 1)
        apop1_means = sim_genotypes[:,300:400].mean(axis=1)
        apop1_keep = np.logical_and(apop1_means > 0, apop1_means < 1)
        #pop2_means = sim_genotypes[:,400:600].mean(axis=1)
        #pop2_keep = np.logical_and(pop2_means > 0.1, pop2_means < 0.9)
        keep = np.logical_and(apop0_keep, apop1_keep)
        #keep = np.logical_and(keep, pop2_keep)

        sim_genotypes = sim_genotypes[keep]

        if sim_genotypes.size != 0:
            genotypes[i] = sim_genotypes[np.random.randint(sim_genotypes.shape[0])]
            i+=1
            if i % 100 == 0:
                print(i)


    # combine haploid individuals into diploid
    genotypes_modern1 = genotypes[:,0:100] + genotypes[:,100:200]
    genotypes_ancestral1 = genotypes[:,200:250] + genotypes[:,250:300]
    genotypes_ancestral2 = genotypes[:,300:350] + genotypes[:,350:400]

    genotypes = np.hstack((genotypes_modern1,
                           genotypes_ancestral1,
                           genotypes_ancestral2))

    sample_times = [time_merge+10 for i in range(100)] + [0 for i in range(100)]
    return genotypes, sample_times



if __name__ == "__main__":
    np.random.seed(21996)
    for i in range(1,11):
        genotypes, sample_times = simulate_scenario_a(5000)
        np.savetxt("scenario_a_genotypes_" + str(i), genotypes, fmt="%i", delimiter='')
        np.savetxt("scenario_a_times_" + str(i), sample_times, fmt="%i", delimiter="\n")
    