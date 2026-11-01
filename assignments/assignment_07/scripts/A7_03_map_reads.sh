#!/bin/bash
set -euo pipefail

# 03_map_reads.sh

# Activate conda env
module load miniforge3
eval "$(conda shell.bash hook)"
conda activate assignment_07_env

# Create the output directory if it doesn't exist
mkdir -p ./output

# Define vars
REF_GENOME="./data/dog_reference.fasta"
INDEX_DIR="./output/bbmap_index"

#Make the index once for the reference with explicit memory limits
mkdir -p "${INDEX_DIR}"
echo "Making reference index..."
bbmap.sh -Xmx24g ref="${REF_GENOME}" path="${INDEX_DIR}"

# Get all the R1 clean reads and map them alongside their R2 pairs
# Adjust for naming convention (e.g., "*_1.trimmed...")
find ./data/clean -type f -name "*_R1.trimmed.fastq.gz" -print0 | while IFS= read -r -d '' file_r1; do
    
    # Use bash string substitution to find the matching R2 file
    file_r2="${file_r1/_R1/_R2}"
    
    # Extract just the sample name for a clean output filename
    BASE_NAME=$(basename "${file_r1}" _R1.trimmed.fastq.gz)
    
    # Verification: Ensure the R2 file actually exists before mapping
    if [[ ! -f "${file_r2}" ]]; then
        echo "Error: Missing reverse pair for ${file_r1}. Skipping."
        continue
    fi

    echo "bbmaping sample: ${BASE_NAME}"
    echo "  R1: ${file_r1}"
    echo "  R2: ${file_r2}"

    # Run bbmap on both reads to preserve insert-size and pair information
    #flags are explained in assignment_07 README.md
    bbmap.sh -Xmx24g \
        path="${INDEX_DIR}" \
        in="${file_r1}" \
        in2="${file_r2}" \
        out="./output/${BASE_NAME}.mapping.bam" \
        ambiguous=best \
        minid=0.95 \
        threads=16

    echo "bbmaping of ${BASE_NAME} complete."
done

# Optional: Clean up the index directory when all samples finish
# rm -rf "${INDEX_DIR}"

#Call samtools on the sam files to keep only mapped results 
#flags are explained in assignment_07 README.md
find ./output -type f -name "*.mapping.bam" -print0 | while IFS= read -r -d '' file_bam; do

    out_bam="${file_bam/.mapping.bam/_dog_matches.bam}"

    samtools view \
    -b \
    -F 4 \
    "${file_bam}" > "${out_bam}"

done
