#!/usr/bin/env bash
# Description: Download the reference genome sequence for Canis familiaris using NCBI datasets CLI.
# Usage: ./download_dog_reference.sh

set -euo pipefail

OUTPUT_ZIP="canis_familiaris_reference_genome.zip"
OUTPUT_DIR="canis_familiaris_genome"

echo "==> Downloading Canis familiaris reference genome..."
datasets download genome taxon "Canis familiaris" \
    --reference \
    --include genome \
    --filename "$OUTPUT_ZIP"

echo "==> Extracting reference genome into '$OUTPUT_DIR'..."
unzip -q -o "$OUTPUT_ZIP" -d "$OUTPUT_DIR"

echo "==> Completed! Reference FASTA files are located in: $OUTPUT_DIR/ncbi_dataset/data/"