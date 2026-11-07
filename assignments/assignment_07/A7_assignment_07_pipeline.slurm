#!/bin/bash
#SBATCH --job-name=assignment_07_test
#SBATCH --nodes=1 # how many physical machines in the cluster 
#SBATCH --ntasks=1 # how many separate 'tasks' (stick to 1)
#SBATCH --cpus-per-task=16 # how many cores (bora max is 20) (should be 16 for real run)
#SBATCH --mem=28G #How much we need.
#SBATCH --time=24:00:00 # d-hh:mm:ss or just No. of minutes #12 hr for real run.
#SBATCH -o ./logs/A7test_%j.out #STDOUT to file (%j is jobID)
#SBATCH -e ./logs/A7test_%j.err #STDERR to file (%j is jobID)
#SBATCH --mail-type=FAIL,END # when to email you
#SBATCH --mail-user=jbusbin@wm.edu # who to email

set -ueo pipefail

#Activate conda env (another time, just to be sure)
module load miniforge3
eval "$(conda shell.bash hook)"

#assignment_07_pipeline.slurm
#details in README.md

./scripts/A7_tool_setup.sh

./scripts/A7_01_download_data.sh

./scripts/A7_02_clean_reads.sh

./scripts/A7_03_map_reads.sh
