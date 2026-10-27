#!/usr/bin/env bash
# Description: Download SRA runs listed in the first column of a CSV file using fasterq-dump.
# Usage: ./download_sra.sh [accessions.csv] [output_directory]

set -euo pipefail

CSV_FILE="${1:-accessions.csv}"
OUT_DIR="${2:-./sra_fastq}"

if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: File '$CSV_FILE' does not exist." >&2
    exit 1
fi

mkdir -p "$OUT_DIR"

# Read the first column:
# - tail -n +2 skips the header line (omit if your CSV lacks a header)
# - cut -d',' -f1 selects the first column
# - tr -d '"\r ' removes quotation marks, carriage returns, and whitespace
tail -n +2 "$CSV_FILE" | cut -d',' -f1 | tr -d '"\r ' | while IFS= read -r acc; do
    [[ -z "$acc" ]] && continue
    echo "==> Downloading SRA accession: $acc"
    fasterq-dump "$acc" \
        --outdir "$OUT_DIR" \
        --split-files \
        --progress
done

echo "==> SRA download completed. Files saved to: $OUT_DIR"