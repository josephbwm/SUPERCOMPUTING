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


#clean up ./assemblies/assembly_module
find ./assemblies/assembly_module/ -mindepth 1 -maxdepth 1 ! -name assembly.fasta ! -name flye.log -exec rm -rf {} +

#rename
mv ./assemblies/assembly_module/assembly.fasta ./assemblies/assembly_module/module_assembly.fasta
mv ./assemblies/assembly_module/flye.log ./assemblies/assembly_module/module_flye.log

#nothing to deactivate
