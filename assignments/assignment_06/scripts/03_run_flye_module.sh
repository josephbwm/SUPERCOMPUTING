#!/bin/bash

set -ueo pipefail

#03_run_flye_module.sh
#run from assignment_06 directory

#load miniforge from module
module load miniforge3

#load flye from module
module load Flye

#specify inputs and output
IN="./data/SRR33939694.fastq"
OUT="./assemblies/assembly_module"

#run flye with our command
flye --nano-hq "${IN}" --out-dir "${OUT}" -t 6 --meta --min-overlap 1000


#clean up ./assemblies/assembly_conda
find . -maxdepth 1 -type f ! -name "assembly.fasta" ! -name "flye.log" -delete

#rename
mv assembly.fasta module_assembly.fasta
mv flye.log module_flye.log

#nothing to deactivate
