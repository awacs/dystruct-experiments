#!/usr/bin/env/ python
import argparse
import numpy as np
import pickle
import sys

parser = argparse.ArgumentParser(description='Simulate genotype data across generations.')
parser.add_argument('-k', type=int, help='number of populations')
parser.add_argument('-l', type=int, help='number of loci')
parser.add_argument('-s', '--seed', type=int, help='random seed to run simulation')
parser.add_argument('--set', type=str, help='simulation set')
parser.add_argument('--sizes', nargs='+', type=int,
                    help='haploid effective population sizes for each population')
parser.add_argument('--time-points', nargs='+', type=int,
                    help='generations to sample from populations')
parser.add_argument('--samples', nargs='+', type=int,
                    help='number of individuals sampled at time point')
parser.add_argument('--admix', nargs='*', type=float,
                    help='percentage admix from pop1 to pop2 followed by time')
parser.add_argument('--admixt', nargs='*', type=int,
                    help='time point of admixture')
args = parser.parse_args()
# global parameters
K = args.k
L = args.l
sim_set = args.set
seed = args.seed
pop_sizes = args.sizes
assert len(args.samples) == len(args.time_points), "length of samples and length of time points must be equal"

ids = np.argsort(args.time_points)
time_points = np.array(args.time_points)[ids]
samples = np.array(args.samples)[ids]

T = max(time_points)+1
admix_prop=args.admix
admix_time=args.admixt
print(admix_time)
if admix_time is not None:
  assert min(admix_time)>0
  assert max(admix_time)<T
  alphas=[0]*T
  for i in range(len(admix_time)):
    alphas[admix_time[i]]=admix_prop[i]
time_samples = {}
for idx,t in enumerate(time_points):
    time_samples[t] = samples[idx]
for t in range(T):
    if t not in time_points:
        time_samples[t] = 0



alpha = np.array([1.0 / K for i in range(K)])
outfile1 = "samples"
outfile2 = "theta"
outfile3 = "freqs"
outfile4 = "generations"


def generate_allele_frequencies():
    beta = np.zeros((T, K, L))

    for k in range(K):
        for l in range(L):
            beta[0][k][l] = np.random.uniform(0.2, 0.8)
    
    for t in range(1, T):
        if alphas is None:
            for k in range(K):
                for l in range(L):
                    n = np.random.binomial(2*pop_sizes[k], beta[t-1][k][l])
                    beta[t][k][l] = n/(2*pop_sizes[k])
        else:
            for k in range(K-1):
                for l in range(L):
                    n = np.random.binomial(2*pop_sizes[k], beta[t-1][k][l])
                    beta[t][k][l] = n/(2*pop_sizes[k])
            for l in range(L): # looking at pop K-1
                alpha=alphas[t]
                n = np.random.binomial(2*pop_sizes[K-1], (1-alpha)*beta[t-1][K-1][l]+alpha*beta[t-1][K-2][l])
                beta[t][K-1][l] = n/(2*pop_sizes[K-1])
    return beta


def generate_theta():
    theta = [ [ [ 0 for k in range(K) ] for j in range(time_samples[t]) ] for t in range(T) ]
    for t in range(T):
        for d in range(time_samples[t]):
            if sim_set.lower() == "admixed":
                dr = np.random.dirichlet(alpha).tolist()
                for k in range(K):
                    theta[t][d][k] = dr[k]
            elif sim_set.lower() == "merger":
                if t < len(time_samples) - 1 and d < 0.5*time_samples[t]:
                    theta[t][d][0] = 1
                    theta[t][d][1] = 0
                elif t < len(time_samples) - 1 and d >= 0.5*time_samples[t]:
                    theta[t][d][0] = 0
                    theta[t][d][1] = 1
                elif t == len(time_samples) - 1:
                    dr = np.random.dirichlet([1,1])
                    for k in range(K):
                        theta[t][d][k] = dr[k]
            elif sim_set.lower() == "merger3":
                if t < len(time_samples) - 1 and d < (1/3.)*time_samples[t]:
                    theta[t][d][0] = 1
                    theta[t][d][1] = 0
                    theta[t][d][2] = 0
                elif t < len(time_samples) - 1 and d < (2/3.)*time_samples[t]:
                    theta[t][d][0] = 0
                    theta[t][d][1] = 1
                    theta[t][d][2] = 0
                elif t < len(time_samples) - 1:
                    theta[t][d][0] = 0
                    theta[t][d][1] = 0
                    theta[t][d][2] = 1
                elif t == len(time_samples) - 1:
                    dr = np.random.dirichlet([1,1,1])
                    for k in range(K):
                        theta[t][d][k] = dr[k]
            else:
                print("bad simulation set")
                sys.exit(1)
    return theta


def generate_samples(theta, beta):
    X = [ [ [ 0 for l in range(L) ] for j in range(time_samples[t]) ] for t in range(T) ]

    for t in range(T):
        for d in range(time_samples[t]):
            for l in range(L):
                p = 0.0
                for k in range(K):
                    p += theta[t][d][k]*beta[t][k][l]
                if p >= 1 and abs(1 - p) < 0.0001:
                    p = 1
                X[t][d][l] = np.random.binomial(2, p)
    return X

if __name__ == "__main__":
    print('Simulating:')
    print('   {} individuals'.format(sum(samples)))
    print('   {} loci'.format(L))
    print('   {} generations'.format(len(time_samples)))
    print('   {} populations'.format(K))
    #print('   {} population sizes'.format(pop_sizes))
    #print('   {} sample times'.format(time_samples))
    np.random.seed(seed)

    beta = generate_allele_frequencies()
    theta = generate_theta()
    X = generate_samples(theta, beta)

    SNP = [] # generation sampled + SNPs
    theta_fmt = [] # theta
    generations = []
    for t in range(T):
        for d in range(len(X[t])):
            generations.append(t)
            row = []
            for l in X[t][d]:
                row.append(l)
            SNP.append(row)

            row = []
            for k in theta[t][d]:
                row.append(k)
            theta_fmt.append(row)

    SNP = np.array(SNP, dtype=int)
    np.savetxt(outfile1, SNP.T, fmt="%d", delimiter="")

    theta_fmt = np.array(theta_fmt)
    np.savetxt(outfile2, theta_fmt, fmt="%.5f", delimiter="\t")

    with open(outfile3, "w") as f:
        for t in range(beta.shape[0]):
            if (time_samples[t] > 0):
                f.write(str(t) + "\n");
                for l in range(beta.shape[2]):
                    for k in range(beta.shape[1] - 1):
                        f.write(str(beta[t][k][l]) + "\t")
                    f.write(str(beta[t][K-1][l]) + "\n")
                f.write("\n")

    generations = np.array(generations)
    generations = generations.reshape((generations.size, 1))
    np.savetxt(outfile4, generations, fmt="%i")
        
