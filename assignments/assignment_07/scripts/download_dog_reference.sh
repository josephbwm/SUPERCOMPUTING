#!/usr/bin/env bash
# Description: Download the reference genome sequence for Canis familiaris using NCBI datasets CLI.
# Usage: ./download_dog_reference.sh
#Run from assignment_07 directory 

set -euo pipefail

#activate conda env
module load miniforge3

eval "$(conda shell.bash hook)"

conda activate assignment_07_env

OUTPUT_ZIP="canis_familiaris_reference_genome.zip"
OUTPUT_DIR="./data/dog_reference"

echo "Downloading Canis familiaris reference genome..." 
datasets download genome taxon "Canis familiaris" \
    --reference \
    --include genome \
    --filename "${OUTPUT_DIR}"

echo "Extracting reference genome into ${OUTPUT_DIR}..."
unzip -q -o "${OUTPUT_ZIP}" -d "${OUTPUT_DIR}"

echo "Completed! Reference FASTA files are located in: ${OUTPUT_DIR}"