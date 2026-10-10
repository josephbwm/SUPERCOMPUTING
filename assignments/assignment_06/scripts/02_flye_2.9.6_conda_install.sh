#!/bin/bash

set -ueo pipefail

#flye_2.9.6_conda_install.sh
#Installs flye via conda env.

#first step
module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
	#or is this supposed to be eval "$(conda shell.bash hook)"?
	
#Use mamba to create, found in bioconda channel
mamba create -y -n flye-env flye -c bioconda

#Use conda to active the enviroment
conda activate flye-env

#Test version 
flye -v

#export env
conda env export --no-builds > flye-env.yml

#deactivate for now
conda deactivate
