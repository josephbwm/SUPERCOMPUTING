#!/bin/bash

set -ueo pipefail

#01_download_data.sh

#Get SRA data

bash ./scripts/download_sra.sh ./SraRunTable.csv ./data/raw

#Get reference

bash ./scripts/download_dog_reference.sh

