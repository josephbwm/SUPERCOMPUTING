#!/bin/bash

set -ueo pipefail

#03_run_flye_local.sh
#run from assignment_06 directory

#Add to PATH (if not already there)
export PATH=$PATH:~/programs/Flye/bin

#check that it is in our PATH (just for saftey)
command -v flye >/dev/null 2>&1 || { echo "Error: flye not found in PATH" >&2; exit 1; }

#specify inputs and output
IN="./data/SRR33939694.fastq"
OUT="./assemblies/assembly_local"

#nothing to activate

#run flye with our command
flye --nano-hq "${IN}" --out-dir "${OUT}" -t 6 --meta --min-overlap 1000

#clean up ./assemblies/assembly_local
find ./assemblies/assembly_local/ -mindepth 1 -maxdepth 1 ! -name assembly.fasta ! -name flye.log -exec rm -rf {} +

#rename
mv ./assemblies/assembly_local/assembly.fasta ./assemblies/assembly_local/local_assembly.fasta
mv ./assemblies/assembly_local/flye.log ./assemblies/assembly_local/local_flye.log

#nothing to deactivate
