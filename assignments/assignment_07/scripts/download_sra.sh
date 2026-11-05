#!/usr/bin/env bash
# Description: Download SRA runs listed in the first column of a CSV file using fasterq-dump.
# Usage: ./download_sra.sh [accessions.csv] [output_directory]

set -euo pipefail

# Activate conda env
module load miniforge3
eval "$(conda shell.bash hook)"
conda activate assignment_07_env

# Set variable names
CSV_FILE="${1:-./SraRunTable.csv}"
OUT_DIR="${2:-./data/raw}"

# Check to see if the file exists
if [[ ! -f "${CSV_FILE}" ]]; then
    echo "Error: File '${CSV_FILE}' does not exist." >&2
    exit 1
fi

# Create the correct target directory
mkdir -p "${OUT_DIR}"
#mkdir -p "/sciclone/scr10/${USER}" #change cluster name to make a scratch directory if you don't have one for unpacking the data.

# Define scratch directory
NODE_SCRATCH="${TMPDIR:-/scr10/$USER/sra_temp}"
mkdir -p "${NODE_SCRATCH}"

# Read the first column, skipping the header
tail -n +2 "${CSV_FILE}" | cut -d',' -f1 | tr -d '"\r ' | while IFS= read -r acc; do
    [[ -z "${acc}" ]] && continue

    echo "==> [1/3] Prefetching: ${acc}"
    prefetch "${acc}" -O "${OUT_DIR}"

    echo "==> [2/3] Extracting FASTQ: ${acc}"
    # Target local node scratch for temp files, and restrict threads to SLURM allocation
    #flags explain in assignment_07 README.md
    fasterq-dump "${OUT_DIR}/${acc}" \
        --outdir "${NODE_SCRATCH}" \
        --split-files \
        --temp "${NODE_SCRATCH}" \
        --threads "${SLURM_CPUS_PER_TASK:-4}" \
        --progress

    echo "==> [3/3] Compressing and renaming: ${acc}"
    # SRA outputs _1 and _2. We rename to _R1 and _R2 while compressing to save I/O time.
    # We check if the files exist first (some SRA entries are single-end and won't have a _2).
    # Compress the massive text files located in scratch directly into compressed files in output directory
    # Use pigz (parallel gzip) to compress using all available SLURM cores
    if [[ -f "${NODE_SCRATCH}/${acc}_1.fastq" ]]; then
        pigz -c -p "${SLURM_CPUS_PER_TASK:-4}" "${NODE_SCRATCH}/${acc}_1.fastq" > "${OUT_DIR}/${acc}_R1.fastq.gz"
        rm "${NODE_SCRATCH}/${acc}_1.fastq"
    fi
    
    if [[ -f "${NODE_SCRATCH}/${acc}_2.fastq" ]]; then
        pigz -c -p "${SLURM_CPUS_PER_TASK:-4}" "${NODE_SCRATCH}/${acc}_2.fastq" > "${OUT_DIR}/${acc}_R2.fastq.gz"
        rm "${NODE_SCRATCH}/${acc}_2.fastq"
    fi

    # Clean up the .sra download folder to reclaim space
    rm -rf "${OUT_DIR:?}/${acc}"
done

echo "==> SRA download completed. Compressed files saved to: ${OUT_DIR}"