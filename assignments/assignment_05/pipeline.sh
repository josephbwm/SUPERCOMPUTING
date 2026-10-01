#!/bin/bash

set -ueo pipefail

#pipeline.sh
#We start from the assignment_05 directory
#First run 01_download_data.sh
bash ./scripts/01_download_data.sh

#Now the for loop
for FWD in ./data/raw/*R1_001.subset.fastq.gz
do
	bash ./scripts/02_run_fastp.sh ${FWD}
done
