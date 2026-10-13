#!/bin/bash

set -ueo pipefail

#pipeline.sh
#the pipeline to use all of the scripts that we have build in assignment_06
#starts from assignment_06 directory

#call the 01 scripts for data
bash 01_download_data.sh

#call the 02 scripts for flye (except module)
bash 02_flye_2.9.6_conda_install.sh

bash 02_flye_2.9.6_manual_build.sh

#call the 03 scripts to run in the three ways
bash 03_run_flye_conda.sh

bash 03_run_flye_local.sh

bash 03_run_flye_module.sh

#check the tail of each of the files

for i in local conda module; do #use and inline list here
	echo "checking ${i} logs:" 
	tail -n 10 "./assemblies/assembly_${i}/${i}_flye.log"
done
#it should, by standard, print to STDOUT the way it is without redirect.
