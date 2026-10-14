#!/bin/bash
#SBATCH --job-name=A6RUN
#SBATCH --nodes=1 # how many physical machines in the cluster
#SBATCH --ntasks=1 # how many separate 'tasks' (stick to 1)
#SBATCH --cpus-per-task=2 # how many cores (bora max is 20)
#SBATCH --time=120 # d-hh:mm:ss or just No. of minutes
#SBATCH -o A6RUN_%j.out #STDOUT to file (%j is jobID)
#SBATCH -e A6RUN_%j.err #STDERR to file (%j is jobID)

#A6_job_script.sh
#Run from assignment_06 directory 

bash pipeline.sh


