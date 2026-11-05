#!/bin/bash
#SBATCH --job-name=assignment_07_test
#SBATCH --nodes=1 # how many physical machines in the cluster 
#SBATCH --ntasks=1 # how many separate 'tasks' (stick to 1)
#SBATCH --cpus-per-task=4 # how many cores (bora max is 20)
#SBATCH --mem=8G #How much we need.
#SBATCH --time=01:00:00 # d-hh:mm:ss or just No. of minutes 

# Description: Generate a CSV summary table of mapping statistics for all BAM files.
# Usage: sbatch 04_mapping_stats.sh (or run interactively)

set -euo pipefail

# Activate conda env
module load miniforge3
eval "$(conda shell.bash hook)"
conda activate assignment_07_env

# Define output table
OUTPUT_CSV="./output/mapping_summary.csv"

# 1. Write the CSV header
echo "Sample,Total_Reads,Mapped_Reads,Percent_Mapped" > "${OUTPUT_CSV}"

echo "Starting flagstat analysis..."

# 2. Use a bash glob instead of 'find' to automatically traverse the symlink
for bam_file in ./output/*.mapping.bam; do
    
    # Safety check: if no files match, the loop variable becomes the literal string "*.mapping.bam"
    if [[ ! -e "${bam_file}" ]]; then
        echo "Error: No .mapping.bam files found in ./output/"
        exit 1
    fi

    BASE_NAME=$(basename "${bam_file}" .mapping.bam)
    echo "  Analyzing ${BASE_NAME}..."
    
    # Run flagstat once using SLURM threads for fast decompression
    stats=$(samtools flagstat -@ "${SLURM_CPUS_PER_TASK:-4}" "${bam_file}")
    
    # Extract the exact numbers
    # The first line of flagstat always reports total QC-passed reads
    qc_total=$(echo "${stats}" | head -n 1 | awk '{print $1}')
    
    # Extract the absolute mapped count and the percentage
    mapped=$(echo "${stats}" | awk '/mapped \(/ {print $1}')
    percent=$(echo "${stats}" | awk -F'[(%]' '/mapped \(/ {print $2}')
    
    # 3. Append a new row to the CSV table
    echo "${BASE_NAME},${qc_total},${mapped},${percent}%" >> "${OUTPUT_CSV}"

done

echo "Done! Summary table generated at: ${OUTPUT_CSV}"