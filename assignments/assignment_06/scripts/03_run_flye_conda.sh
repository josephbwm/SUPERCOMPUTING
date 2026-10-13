#!/bin/bash

set -ueo pipefail

#03_run_flye_conda.sh
#run from assignment_06 directory

#load miniforge from module
module load miniforge3

#activate conda
eval "$(conda shell.bash hook)"

#activate Flye env
conda activate flye

#specify inputs and output
IN="./data/SRR33939694.fastq"
OUT="./assemblies/assembly_conda"

#run flye with our command
flye --nano-hq "${IN}" --out-dir "${OUT}" -t 6 --meta --min-overlap 1000


#clean up ./assemblies/assembly_conda
find . -maxdepth 1 -type f ! -name "assembly.fasta" ! -name "flye.log" -delete

#rename
mv assembly.fasta conda_assembly.fasta
mv flye.log conda_flye.log

#deactivate Flye
conda deactivate
conda deactivate #one extra to be safe...
