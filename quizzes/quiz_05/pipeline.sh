#!/bin/bash
set -ueo pipefail

#pipeline.sh for quiz_05
#assume our scripts are executable, and in quiz_05/scripts
#We just run the scripts

bash ./scripts/01_prep_data.sh
bash ./scripts/02_get_stats.sh
bash ./scripts/03_cleanup.sh
