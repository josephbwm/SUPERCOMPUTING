#!/bin/bash
#SBATCH --job-name=test_hello
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1
#SBATCH --mem=1G
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=jbusbin@wm.edu               # changed to my email!
#SBATCH -o test_hello_%j.out			 #%j is job ID
#SBATCH -e test_hello_%j.err			 #will go to place of script, which is okay

echo "Hello world!" #code to run

