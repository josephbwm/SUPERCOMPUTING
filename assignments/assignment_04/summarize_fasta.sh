#!/bin/bash 
set -ueo pipefail

#summarize_fasta.sh
	
#Accept file
FILE_NAME="$1"

#Get statisics from summary
#Second row, 4th column
TOTAL_SEQs=$(seqkit stats -T "$FILE_NAME" | awk 'NR==2 {print $4}')

#Second row, 5th column
TOTAL_NB=$(seqkit stats -T "$INPUT_FILE" | awk 'NR==2 {print $5}')

#Temp file
TEMP_TABLE=$(mktemp /tmp/seq_lengths.XXXXXX.txt)

seqkit fx2tab --name --length "$FILE_NAME" > "$TEMP_TABLE"

#Output
echo "Total number of sequences: $TOTAL_SEQS"
echo "Total number of nucleotides: $TOTAL_NB"
echo "Table of lengths successfully stored at: $TEMP_TABLE"

