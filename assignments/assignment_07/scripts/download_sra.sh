#!/usr/bin/env bash
# Description: Download SRA runs listed in the first column of a CSV file using fasterq-dump.
# Usage: ./download_sra.sh [accessions.csv] [output_directory]

set -euo pipefail

#activate conda env
module load miniforge3

eval "$(conda shell.bash hook)"

conda activate assignment_07_env

#set variable names
CSV_FILE="${1:-./data/SraRunTable.csv}"
OUT_DIR="${2:-./data/raw}"

#check to see if the file exists
if [[ ! -f "${CSV_FILE}" ]]; then
    echo "Error: File '${CSV_FILE}' does not exist." >&2
    exit 1
fi

#make the data/raw directory if it does not already exist
mkdir -p "./data/raw"

# Read the first column:
# - tail -n +2 skips the header line (omit if your CSV lacks a header)
# - cut -d',' -f1 selects the first column
# - tr -d '"\r ' removes quotation marks, carriage returns, and whitespace
tail -n +2 "${CSV_FILE}" | cut -d',' -f1 | tr -d '"\r ' | while IFS= read -r acc; do
    [[ -z "${acc}" ]] && continue

    #We prefetch the data first for better downloads and diskspace
    echo "==> [1/2] Prefetching: $acc"
    prefetch "${acc}" -O "${OUT_DIR}"

    echo "==> [2/2] Extracting FASTQ: $acc"
    fasterq-dump "${OUT_DIR}/${acc}" \
        --outdir "${OUT_DIR}" \
        --split-files \
        --progress

    # Clean up the .sra download folder to reclaim space
    rm -rf "${OUT_DIR:?}/${acc}"
done

echo "==> SRA download completed. Files saved to: ${OUT_DIR}"

