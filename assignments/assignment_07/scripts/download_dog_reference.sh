#!/usr/bin/env bash
# Description: Download the reference genome sequence for Canis familiaris using NCBI datasets CLI.
# Usage: ./download_dog_reference.sh
#Run from assignment_07 directory 

#!/usr/bin/env bash
# Description: Download the reference genome sequence for Canis familiaris using NCBI datasets CLI.
# Usage: ./download_dog_reference.sh
# Run from assignment_07 directory 

set -euo pipefail

# Activate conda env
module load miniforge3
eval "$(conda shell.bash hook)"
conda activate assignment_07_env

# Define variables
DATA_DIR="./data/dog_reference"
OUTPUT_ZIP="${DATA_DIR}/canis_familiaris_reference_genome.zip"
FINAL_FASTA="${DATA_DIR}/canis_familiaris_reference_genome.fasta"

# 1. Create the data directory if it doesn't exist
mkdir -p "${DATA_DIR}"

echo "Downloading Canis familiaris reference genome..." 
# 2. Download the ZIP file using the OUTPUT_ZIP variable
datasets download genome taxon "Canis familiaris" \
    --reference \
    --include genome \
    --filename "${OUTPUT_ZIP}"

echo "Extracting reference genome..."
# 3. Extract the zip file into the data directory
unzip -q -o "${OUTPUT_ZIP}" -d "${DATA_DIR}"

echo "Moving and renaming FASTA file to ${FINAL_FASTA}..."
# 4. NCBI datasets buries the file in ncbi_dataset/data/GCF_.../*.fna
# This finds that specific file, moves it to ./data/, and renames it to dog_reference.fasta
find "${DATA_DIR}/ncbi_dataset/data" -type f -name "*.fna" -exec mv {} "${FINAL_FASTA}" \;

echo "Cleaning up temp files..."
# 5. Remove the ZIP file and the extracted NCBI folder structure
rm "${OUTPUT_ZIP}"
rm -rf "${DATA_DIR}/ncbi_dataset"
rm -f README.md md5sum.txt # Remove standard NCBI package text files

echo "Completed! Reference FASTA file is located at: ${FINAL_FASTA}"