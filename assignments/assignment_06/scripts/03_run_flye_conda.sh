#!/bin/bash

set -ueo pipefail

#03_run_flye_conda.sh
#run from assignment_06 directory

#load miniforge from module
module load miniforge3

#activate conda
eval "$(conda shell.bash hook)"

#activate Flye env
conda activate flye-env

#specify inputs and output
IN="./data/SRR33939694.fastq"
OUT="./assemblies/assembly_conda"

#run flye with our command
flye --nano-hq "${IN}" --out-dir "${OUT}" -t 6 --meta --min-overlap 1000


#clean up ./assemblies/assembly_conda
find ./assemblies/assembly_conda/ -mindepth 1 -maxdepth 1 ! -name assembly.fasta ! -name flye.log -exec rm -rf {} +

#rename
mv ./assemblies/assembly_conda/assembly.fasta ./assemblies/assembly_conda/conda_assembly.fasta
mv ./assemblies/assembly_conda/flye.log ./assemblies/assembly_conda/conda_flye.log

#deactivate Flye
conda deactivate
conda deactivate #one extra to be safe...
