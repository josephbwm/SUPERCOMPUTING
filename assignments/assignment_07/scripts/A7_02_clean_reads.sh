#!/bin/bash

set -ueo pipefail

#activate conda env
module load miniforge3

eval "$(conda shell.bash hook)"

conda activate assignment_07_env

#Create the clean directory if it doesn't exist
mkdir -p ./data/clean

#Use 'find' to search for files by name. 
#-print0 outputs a null byte after each filename (handles spaces safely, matching read -d '')
find ./data/raw -type f -name "*_R1*.fastq.gz" -print0 | while IFS= read -r -d '' file; do
    
    echo "Processing file: ${file}"
    
    FWD_IN="${file}"
    
    #Replace "_R1" (this way avoids breaking path names that happen to contain "R1")
    REV_IN="${FWD_IN/_R1/_R2}"
    
    #Generate output names (replaces raw/ with clean/ and tacks on .trimmed in the name)
    FWD_OUT="${FWD_IN/raw\//clean\/}"
    FWD_OUT="${FWD_OUT/.fastq.gz/.trimmed.fastq.gz}"
    
    REV_OUT="${REV_IN/raw\//clean\/}"
    REV_OUT="${REV_OUT/.fastq.gz/.trimmed.fastq.gz}"

    #Call fastp
    #flags are explained in README.md for assignment_07
    fastp --in1 "${FWD_IN}" \
          --in2 "${REV_IN}" \
          --out1 "${FWD_OUT}" \
          --out2 "${REV_OUT}" \
          --json /dev/null \
          --html /dev/null \
          --trim_front1 20 \
          --trim_front2 20 \
          --trim_tail1 20 \
          --trim_tail2 20 \
          --n_base_limit 0 \
          --length_required 100 \
          --average_qual 20

done