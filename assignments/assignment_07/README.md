## assignment_07 README.md

### 1. Directory stucture:
A7_assignment_07_pipeline.slurm

data
- clean
- dog
- raw

output
- SRR#_dog_matches.bam
- SRR#.mapping.bam

scripts
- A7_tool_setup.sh
- A7_01_download_data.sh
- download_sra.sh
- download_dog_reference.sh
- A7_02_clean_reads.sh
- A7_03_map_reads.sh
- A7_04_mapping_stats.sh
- A7_testing_script.sh

SraRunTable.csv

README.md

assignemnt_07_env.yml

mapping_summary.csv

logs
- assignment_07.err
- assignment_07.out
		
### Tool setup:
For this assignment I am choosing to use conda enviroments.
So through conda I am making enviroments for: datasets,
sra-toolkit, bbmap, samtools, fasterq-dump, pigz, and fastp

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

For the fasterq-dump flags:
I learned that I do have a temp directory, and that using it to throttle data IO is important.
+ ` --temp "${TMPDIR:-/sciclone/scr10/${USER}}" `  
+ ` --threads "${SLURM_CPUS_PER_TASK:-4}" ` : to limit the number of threads used
+ ` --progress ` : to show progress (generates a lot of text into logs)
+ ` --threads "${SLURM_CPUS_PER_TASK:-4}" ` : a saftly measure to llimit fasterq-dump, it can't use so many anyways.

### 3. Clean up data
I took the baseline of fastp trimming with variable subsitution from assignement_05, then modified by putting it in a while loop that looks for all files containing "R1" in them, and preforms the name subsitutions desired. This may have to be changed on testing if the data files are especially unconventionally named.
For the fastp flags, because my SRA data is coming from a wide varitey of sources, I deemed a more generic apporach is probably the safest bet. 
+ `--average_qual 20` : NCBI standard
+ `--n_base_limit 0` : Deal with uncertain bases would be non-optimal, NCBI standard is 5
+ `--trim_front1 20 --trim_front2 20 --trim_tail1 20 --trim_tail2 20` : trim all of the lower quality ends off, NCBI standard.
+ `--length_required 100` : anything below this is too short to be a reasonble match, double NCBI standard.

### 4. Map clean reads to dog genome

Flags for bbmap:
- `path="${INDEX_DIR}"` tells bbmap that we already have refernce index we are using, and it's already made hopefully this speeds things up.
- `ambiguous=best ` # if multiple matches, pick best one (based on alignment score)
- `minid=0.95 ` specifics that we want at least 95% identity required to match as desired for the assignment.
- `threads=16 ` # Use a good number of threads
- The amount of RAM is based off of the reference genome, at an estimate of about 6 bytes per base and a reference size of approximatly 2.5 Gb, that makes for 18g, so for cusion I will use use 24g.

Before testing I wrote:
> Seeing as we have a number of large genomes, and a pretty big reference, we will request a lot of time from the server fro the job, my guess is about 4 hours at the number of threads, so to be safe, 6 hours should do (other parts may add to this consideration).

After testing you can see that this prediction becomes naive. 
For memory and compute more is better than less is the concpet that informs the SLURM header: 26-28 GB of RAM to accommodate the 24 GB Java heap plus OS and thread overhead, and it requests 16 CPUs.

### 5. Extract reads that matched dog genome
for the find command, -L tells samtools to look in the symulinked output directory. 
The use and flags for samtools is simple here. We call samtools to view which is filtering in this case in a standard while loop.
`-b ` -> expect .bam files
`-F 4 ` -> to onily include reads that matched to the genome

### 6. Submit your job to SLURM
Before I got here I included a testing script to have the tiny files actually run through and have the enviroment set up etc. To use it you run `bash scripts/A7_testing_script.sh` from the assignment_07 directory. I submitted the pipeline without the downloading data step to SLURM for the test. 
On my first try I realized I failed to modify my scripts to be executable. So I changed that with `$chmod 700 *.sh`
On the second try I redirected the logs to the right location.
Before running the whole job, I took another look to check compatability back to my download scripts and fix multiple bugs there.

### 7. Inspect your stdout and stderr
The first two attempts at running the job failed due to minor file path errors. The third attempt was more intresting and was do to storage limit errors, which was resolved bt changing the output of fasterq-dump for the data downloads. A problem only expected to be run into with large files.
On the forth attempt I ran out of storage again, so I instead created a symbolic link from the data folder in that assignment_07 directory to a folder in my scratch directory with:
```
mv ./data ~/sciclone/scr10/jbusbin/assignment_07_data
ln -s ~/sciclone/scr10/jbusbin/assignment_07_data ./data
```
To break the symbolic link it is as simple as using rm or unlink command. DO NOT use rm -rf or else it will delete files in scratch (the linked directory) rather than removing the folder, so unlink is safer in that way. 

However since the data is too big it is also likely that other part such as the output matches will be too large, so we link those as well. 
```
mv ./output /sciclone/scr10/jbusbin/assignment_07_output
ln -s /sciclone/scr10/jbusbin/assignment_07_output ./output
```
This should cause the scripts to run as desired and not have to worry about storage, but now looking back on it, it may have been easier to specifiy the scratch directory as the place for all the data, and the scripts merely operate from a distance in assingment_07 directory. But modificaiton would be more difficult at this point. 
A futher addition to this was to have this structure automatically set up in A7_01_download_data.sh where is creates and links the directories for the user. It assumes a path in the sciclone HPC however.

Since the job took so very long to run, I decided to look into that and found that the data compression might be what is holding the process back, so I wanted to use pigz for parallelized processing. Which should speed it up. That said it completed eventually anyways so lets go! 
ps. It did turn out that pigz is *much* faster.
And I add the held out SRA numbers back into the RunTable.

### 8. Inspect your results

With a quick script to loop through the results we have:
Sample,Total_Reads,Mapped_Reads,Percent_Mapped\
ERR13865292,9194530,3236,3236,0.04,0.04%\
ERR13865299,8592696,3828,3828,0.04,0.04%\
ERR13865300,1167134,5541,5541,0.47,0.47%\
ERR16891046,75106492,8728,8728,0.01,0.01%\
ERR16891055,90664902,44817,44817,0.05,0.05%\
ERR16898309,61519616,506,506,0.00,0.00%\
ERR16898311,59113404,1812,1812,0.00,0.00%\
SRR14470682,32579906,1280,1280,0.00,0.00%\
SRR17622020,41380540,7744,7744,0.02,0.02%\
SRR17622021,39336620,2260,2260,0.01,0.01%\
SRR17622022,39738584,3962,3962,0.01,0.01%\
SRR28211885,144685924,2627,2627,0.00,0.00%\
SRR29324611,81030376,2195,2195,0.00,0.00%\
SRR33545155,50274310,11413,11413,0.02,0.02%\

And we see that thousands or even tens of thousands of mapped reads corresponding to matches with the dog reference. Overall a small percent (execpt in ERR13865300, that is crazy) but, by all means every run apears containinated!

### 9. Document Everything

Metadata:
SraRunTable.cvs is a data table containing the meta data for each genome to download, all ther paired, and thier sources and selection are detailed in **2**. 
Bewarned that the lables at the top may not match all columns of the metadata, on the accension number (the first column) was used. 

Scripts: 

All scripts are expected to be called from the assignment_07 directory.
    
A7_tool_setup.sh is found in scripts and used to create the conda enviroment used to run the tools used in all scripts. It takes no arguments and produces a YAML file. Tool list: datasets, sra-toolkit, bbmap, samtools, fasterq-dump is in sra-toolkit, fastp, and pigz.
See **1** in README.md.

A7_01_download_data.sh is found in scripts, it calls two subscripts download_sra.sh and download_dog_refernce.sh which are also in scripts. **Importantly it assumes a file path in the sciclone HPC for directory setup**, if this is not your HPC, please change where the data and outuput directories will be linked to.
See **2** in README.md.

download_sra.sh is found in scripts, it  is used to prefetch, download, and compress each set of genomic data with fasterq--dump and pigz. It takes two optional arguments. The first argument corresponed the table of data from NCBI run selector and expects the first column to be SRA  ascention numbers, and does not use the rest, so any CSV of ascention number will do. The second argument is the output directory.  
Called by A7_01_download_data.sh.
See **2** in README.md.

download_dog_reference.sh is found in scripts, it is used to get the reference dog genome for Canis familiaris using NCBI datasets CLI.
Called by A7_01_download_data.sh.
See **2** in README.md.

A7_02_clean_reads.sh is found in scripts, it uses fastp to clean the reads, the choices for which are explain in the read me. It expects data to be found in `./data/raw`.
See **3** in README.md.

A7_03_map_reads.sh is found in scripts, it expects the data to be found in `./data/clean` and expects the reference to be found in `./data/dog_reference/` as fastq.gz and fasta files respectivly. It uses bbmap to map the clean samples to the refernece, and then calls samtools to keep the matched dogfilters createing a new set of files from the `.mapped.bam` files or `_dog_matches.bam`.  
See **4 and 5** in README.md.

A7_04_clean_reads.sh is found in scripts, It runs samtools flagstats to compare the number of total read to the number of mapped reads. It operates on the `.mapping.bam` files to give a comparison to the total of the number of strands that matches the dog reference.
It is intented to be run as a stand alone from the assignement_06 directory post pipeline script for optional analysis. It takes no arguments, and expects that `.mapping.bam` files to be in `./output`.

A7_testing_script.sh is foudn in scripts. It is used to generate a simple set of toy data for testing purposes. 

### reflection:
**Challenges:**
I found three major challenges to my conventional understandings.
The first is that while understanding how one tool works is crictial, understanding a pipeline chain of tools is more difficult. The tools must connect and sync to one another. The managing and typing of the files is difficult to keep track of. The tools do so much the can end up hiding or abstracting how much work they do.

The second is just how large data can be. Previously we said large numbers, but it is not until hitting the wall time that you realize how large the data is. It gives a new meaning to the steps of building an efficient pipeline because at this scale computational power can no longer trivialize the inoptimalities in the code you write.
The third is that with the increase in data, not only is computation speed bottle necked, but storage as well. I ran into storage issues multiple times as the files were too large to be premitted outside of the scratch and data directories. 

**New things I learned:** *(In bullet point fasion)*
- Not all tools are automatically setup to use all the threads that you can give them. The example here is pigz vs gz. The first can take advantage of all the cores you give it, the second is designed to only use one.
- Testing is very useful, but has difficulties representing issues the arise with scale. Tests are by nature small and fast to find issues quickly, but novel issues can arise at scale that would not appear when running smaller tests.
- The setup of the tools was suprizingly easy.
- The debugging was expectedly hard. 
- Modularization is moderatly difficult, and being able to have a script adapt to any HPC via bash variables is useful, but you have to be intentional about it.
- I found that I was not able to trust the scripts together even when I had all individual parts working. I still had to give it a full reboot and run through for my own sanity. 

    






    

    

    

     
	
