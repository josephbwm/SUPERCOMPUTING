#!/bin/bash

set -ueo pipefail

#01_download_data.sh
#Optionally modify the arguments for ./scripts/download_sra.sh. 
#The first argument corresponed the table of data from NCBI run selector and expects 
#the first column to be SRA  ascention numbers, and does not use the rest, so any CSV of 
#ascention number will do. The second argument is the output directory.  

#!/usr/bin/env bash
# Description: Initialize scratch storage and symlinks for the pipeline

# Define dynamic scratch directories for the current user
SCRATCH_DATA="/sciclone/scr10/${USER}/assignment_07_data"
SCRATCH_OUT="/sciclone/scr10/${USER}/assignment_07_output"

echo "Initializing HPC storage directories..."

# 1. Create the physical directories on the scratch drive FIRST
mkdir -p "${SCRATCH_DATA}"
mkdir -p "${SCRATCH_OUT}"

# 2. Safely create the data symlink
if [[ ! -L "./data" ]]; then
    echo "Linking ./data to scratch drive..."
    # Remove standard empty folder if it was accidentally created previously
    rm -rf "./data" 2>/dev/null
    ln -s "${SCRATCH_DATA}" ./data
fi

# 3. Safely create the output symlink
if [[ ! -L "./output" ]]; then
    echo "Linking ./output to scratch drive..."
    # Remove standard empty folder if it was accidentally created previously
    rm -rf "./output" 2>/dev/null
    ln -s "${SCRATCH_OUT}" ./output
fi

echo "Workspace initialized. ./data and ./output are now routed to scratch."

#Get SRA data

bash ./scripts/download_sra.sh ./SraRunTable.csv ./data/raw

#Get reference

bash ./scripts/download_dog_reference.sh

