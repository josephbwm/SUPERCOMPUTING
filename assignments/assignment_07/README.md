##assignment_07 README.md

###1. Directory stucture:
	assignment_07_pipeline.slurm
	data
		-clean
		-dog
		-raw
		-Sratable
	output
		- assignment_07.err
		- assignment_07.out
		-SRR#_dog-matches.sam
		-SRR#.sam
	README.md
	Scripts
		01_download_data.sh
		02_clean_reads.sh
		03_map_reads.sh
		
### Tool setup:
	For this assignment I am choosing to use conda enviroments.
	So through conda I am making enviroments for: datasets,
	sra-toolkit, bbmap, samtools, fasterq-dump, and fastp

### 2. Download Sequence Data
    Search Process for SRA data:
	The main approach taken was to use filters or specific terms to find samples that arbitarily seemed of intrest to me.

    My search string changed between various taxons, but had the similar compnets of: 
    (Shotgun[All Fields] AND ("metagenome"[Organism] OR ("metagenome"[Organism] OR metagenome[All Fields])) AND data[All Fields]) AND (cluster_public[prop] AND "biomol dna"[Properties] AND "library layout paired"[Properties] AND "platform illumina"[Properties] AND "strategy wgs"[Properties] OR "strategy wga"[Properties] OR "strategy wcs"[Properties] OR "strategy clone"[Properties] OR "strategy finishing"[Properties] OR "strategy validation"[Properties] AND "filetype fastq"[Properties])

    Except for the Artic Fairy Shrimp Sequence which was not a metagenome, and so did not have that tag.
    Otherwise they varied by taxon, and where selected by browsing the titles.

    Links to each: 
    PRJEB98467 (ERR16891046, ERR16891055, ERR16898309, ERR16898311):
        https://www.ncbi.nlm.nih.gov/bioproject/PRJEB98467
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR16891046&display=metadata
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR16891055&display=metadata
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR16898309&display=metadata
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR16898311&display=metadata

    PRJNA1262068 (SRR33545155):
        https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1262068
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR33545155&display=metadata

    PRJNA1121395 (SRR29324611):
        https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1121395
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR29324611&display=metadata

    PRJNA797383 (SRR17622020, SRR17622021, SRR17622022):
        https://www.ncbi.nlm.nih.gov/bioproject/PRJNA797383
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR17622020&display=metadata
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR17622021&display=metadata
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR17622022&display=metadata

    PRJNA804311 (SRR28211885):
        https://www.ncbi.nlm.nih.gov/bioproject/PRJNA804311
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR28211885&display=metadata

    PRJEB81427 (ERR13865292, ERR13865300, ERR13865299):
        https://www.ncbi.nlm.nih.gov/bioproject/PRJEB81427
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR13865292&display=metadata
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR13865299&display=metadata
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR13865300&display=metadata

    PRJNA728207 (SRR14470682):
        https://www.ncbi.nlm.nih.gov/bioproject/PRJNA728207
        https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR14470682&display=metadata

   For the downloading of the data I broke the problem up into two subscripts to download the sra and reference separatly; both are the simply called in the A7_01_download_data.sh. The download_sra.sh loops through the csv of the sra metadata and prefetches then download each file using fasterq-dump. Note that this script optionally takes command line arguments. The download_dog_reference.sh just uses datasets to download the reference. 


    

    

    

    

     
	
