#!/bin/bash

set -ueo pipefail

#01_download_data.sh

#Get SRA data

bash ./download_sra.sh ./data/SraRunTable.csv ./data/raw

#Get reference

bash ./download_dog_reference.sh

