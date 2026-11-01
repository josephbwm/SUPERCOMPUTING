#!/bin/bash
#SBATCH --job-name=assignment_07
#SBATCH --nodes=4 # how many physical machines in the cluster (should be 16 for real run)
#SBATCH --ntasks=1 # how many separate 'tasks' (stick to 1)
#SBATCH --cpus-per-task=2 # how many cores (bora max is 20)
#SBATCH --time=120 # d-hh:mm:ss or just No. of minutes
#SBATCH -o A6RUN_%j.out #STDOUT to file (%j is jobID)
#SBATCH -e A6RUN_%j.err #STDERR to file (%j is jobID)
#SBATCH --mail-type=FAIL,END # when to email you
#SBATCH --mail-user=jbusbin@wm.edu # who to email

#I choose max memory, and a cluster that has 24gb

set -ueo pipefail

#Activate conda env (another time, just to be sure)
module load miniforge3
eval "$(conda shell.bash hook)"

#assignment_07_pipeline.slurm

./scripts/A7_01_download_data.sh

./scripts/A7_02_clean_reads.sh

./scripts/A7_03_map_reads.sh
