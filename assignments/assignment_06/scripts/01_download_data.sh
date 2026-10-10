#!/bin/bash

set -ueo pipefail

#01_download_data.sh
#./scripts/01_download_data.sh

#script to download data for assignment_06

wget -P ./data https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1

#move to data
cd data

#rename the file so that gunzip can recognize it
mv SRR33939694.fastq.gz?download=1 SRR33939694.fastq.gz

#unzip the file to a fastq
gunzip SRR33939694.fastq.gz

#small data set of sequences from Oxford Nanopore
#Technologies (ONT, AKA: Nanopore) of E. coli phages
