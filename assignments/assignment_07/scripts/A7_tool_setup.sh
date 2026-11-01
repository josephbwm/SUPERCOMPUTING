#!/bin/bash

set -ueo pipefail

#A7_tool_setup.sh
#Setting up conda envs to run the tools 
#Run from assignment_07 directory 

#Load python and conda
module load miniforge3

eval "$(conda shell.bash hook)"

#tool list: datasets, sra-toolkit, bbmap, samtools, fasterq-dump is in sra-toolkit, and fastp

#General Process:	
#1.Download datasets with mamba
#2.Use conda to active the enviroment
#3.Test version to make sure each is working
#4.Export to YAML

#Use mamba to create the env, all our packages are found in bioconda channel
mamba create -y -n assignment_07_env -c conda-forge -c bioconda datasets sra-toolkit bbmap samtools  fastp

#activate and test
conda activate assignment_07_env
datasets --version && srapath --version && bbversion.sh && samtools --version && fastp --version

#export
conda env export --no-builds > assignment_07_env.yml

