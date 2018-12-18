import msprime
import numpy as np


def prune_ld(genotype_matrix):
    pass

def simulate_scenario_b(nloci):
    """Simulate haploid individuals under historical admixture.
    Three populations merge 200 generations ago. Ancient samples are
    from three populations prior to mixture. Modern samples are from
    after admixture event.
    """

    Ne = 5000
    ancestral_Ne = 2500
    time_split1 = 1500
    time_split2 = 3000

    samples = [msprime.Sample(population=0, time=0) for i in range(200)] + \
              [msprime.Sample(population=1, time=0) for i in range(200)] + \
              [msprime.Sample(population=2, time=0) for i in range(200)] + \
              [msprime.Sample(population=1, time=time_split1+50) for i in range(100)]

    pop0 = msprime.PopulationConfiguration(initial_size=Ne)
    pop1 = msprime.PopulationConfiguration(initial_size=Ne)
    pop2 = msprime.PopulationConfiguration(initial_size=Ne)
    pop3 = msprime.PopulationConfiguration(initial_size=Ne)

    population_configurations = [
        pop0,
        pop1,
        pop2,
        pop3
    ]

    demographic_events = [
        # Split 1
        msprime.MassMigration(time=time_split1, source=2, destination=1, proportion=1.0),

        # Split 2
        msprime.MassMigration(time=time_split2, source=1, destination=0, proportion=1.0),

    ]

    #dd = msprime.DemographyDebugger(
    #    population_configurations=population_configurations,
    #    demographic_events=demographic_events)
    #dd.print_history()
    #exit()

    genotypes = None
    for i in range(10):
        tree_sequence = msprime.simulate(samples=samples,
                                         population_configurations=population_configurations,
                                         demographic_events=demographic_events,
                                         mutation_rate=2e-8,
                                         recombination_rate=1e-8,
                                         length=1e7)

        genotype_matrix = tree_sequence.genotype_matrix()


        subset = [ 10*i for i in range(int(nloci/10)) ]
        if genotypes is None:
            genotypes = genotype_matrix[subset,:]
        else:
            genotypes = np.vstack((genotypes, genotype_matrix[subset,:]))

    # combine haploid individuals into diploid
    genotypes_modern1 = genotypes[:,0:100] + genotypes[:,100:200]
    genotypes_modern2 = genotypes[:,200:300] + genotypes[:,300:400]
    genotypes_modern3 = genotypes[:,400:500] + genotypes[:,500:600]
    genotypes_ancestral1 = genotypes[:,600:650] + genotypes[:,650:700]


    genotypes = np.hstack((genotypes_modern1,
                           genotypes_modern2,
                           genotypes_modern3,
                           genotypes_ancestral1))

    sample_times = [time_split1 + 50 for i in range(300)] + [0 for i in range(50)]
    print(genotypes.shape)
    return genotypes, sample_times



if __name__ == "__main__":
    np.random.seed(25708)
    for i in range(1,11):
        genotypes, sample_times = simulate_scenario_b(5000)
        np.savetxt("scenario_b_genotypes_" + str(i), genotypes, fmt="%i", delimiter='')
        np.savetxt("scenario_b_times_" + str(i), sample_times, fmt="%i", delimiter="\n")
    