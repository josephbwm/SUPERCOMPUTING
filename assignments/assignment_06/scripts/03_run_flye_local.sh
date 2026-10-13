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

#clean up ./assemblies/assembly_conda
find . -maxdepth 1 -type f ! -name "assembly.fasta" ! -name "flye.log" -delete

#rename
mv assembly.fasta local_assembly.fasta
mv flye.log local_flye.log

#nothing to deactivate
