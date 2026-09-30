#!/bin/bash

set -ueo pipefail

#/01_download_data.sh

#To download data file
wget https://gzahn.github.io/data/fastq_examples.tar

#extract the data AND put data into ../data/raw
tar -xf fastq_examples.tar -C ./data/raw

#clear tar 
rm fastq_examples.tar
