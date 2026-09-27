#!/bin/bash 
set -ueo pipefail

#count_stuff.sh

#Don't need this variable assignment
#TARGET_1="$1"

TOTAL_COUNT=$(ls -1a $1 | wc -l)
#For this variable assignment we have to have a command subsitution


echo "${TOTAL_COUNT}"
