#!/bin/bash

set -ueo pipefail

#A7_tool_setup.sh

#Setting up conda envs to run the tools 

#Load python and conda
module load miniforge3

eval "$(conda shell.bash hook)""

#General Process:	
#Use mamba to create the env, usually found in bioconda channel
#Use conda to active the enviroment
#Test version to make sure it is working
#export env with one enviroment per YAML file
#It is best practice to keep the envs separate.


#datasets
mamba create -y -n datasets-env datasets -c bioconda
conda activate datasets-env
datasets -v
conda env export --no-builds > datasets-env.yml

#sra-toolkit

#bbmap

#samtools

#fasterq-dump

#fastp


