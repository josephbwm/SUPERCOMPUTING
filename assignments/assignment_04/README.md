Assignment 04 Readme File.

A4 READ ME
Tasks:
1. Already done in class! :) 
2. We want to download precompiled binary programs to run directly.
	Use command line to download and unpack: 
		wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz
		tar -xzvf file.tar.gz
			file = "gh_2.74.2_linux_amd64.tar.gz", so 
			tar -xzvf gh_2.74.2_linux_amd64.tar.gz
			
3. To build the script I add a flag to the previous command so that the file 
is always unpacked into programs:
	tar -xzvf gh_2.74.2_linux_amd64.tar.gz -C ~/programs
	I also need to add the script headers and a rm: 
	#!/bin/bash 
	set -ueo pipefail
	rm gh_2.74.2_linux_amd64.tar.gz
	
4. I did so with: export PATH=$PATH:/sciclone/home/jbusbin/programs/gh_2.74.2_linux_amd64
	and I found the PATH with a nifty command: 
		realpath gh_2.74.2_linux_amd64/
	I remember however that this is temporary.
	
5. I have already done this before the assignment :D 

6. The first part of the script is the same as the other, but I implemented the 
improved file unpacking. I also changed the nature of the addition of the 
PATH, so that now is user specific. The first version would only work for me and my
PATH on the HPC, not for everyone elses. This way it is more reproducable.
	echo "export PATH=$PATH:~/programs/{filename} >> .bashrc"  instead of
	the absolute PATH.
	
7. Lets try some basics (and hopefully not break anything)
	-First make a copy of our file to assignment_04 
	cp GCF_000001735.4_TAIR10.1_genomic.fna ~/SUPERCOMPUTING/assignments/assignment_04/data/raw
	
	-Let's convert the file:
		"seqtk seq -a GCF_000001735.4_TAIR10.1_genomic.fna > FASTA_convert.fna"
		This has turned into just the sequences now it seems.
	-Let's get the reverse completment
		"seqtk seq -r GCF_000001735.4_TAIR10.1_genomic.fna > reverse_comp.fna"
		Not totally sure what a reverse complement is in this context, but we have it!
	-Let's wrap the files so that the lines are reasonably human readable:
		"seqtk seq -l 60 GCF_000001735.4_TAIR10.1_genomic.fna > wrapped.fna"
		so much better to look at the head now.
	-Let's take a random sample fo the gene sequence:
		"seqtk sample GCF_000001735.4_TAIR10.1_genomic.fna 0.1 > ten_percent_sample.fna"

8.
Accpting file input: FILE_NAME="$1"
Here we have command subsitution to assign to a variable, and we see that 
awk strikes again!  
$(seqkit stats -T "$FILE_NAME" | awk 'NR==2 {print $4}')

Not much else to new here, other than that hte states function is great!
 
9. This one is simple, I hope;
	"for f in *.fasta; do ./process_fasta.sh "$f"; done"


Reflection:
The PATH is essentially the guidebook for commands, it tell the computer and additional place
to look for arguments (past what I suppose is build in).

For me understanding the absoulte file paths and the for loop syntex was hard, still not sure
that I have the down completely.

I learned that there are a lot of different ways to install tools, and that some tools can set
themselves up, practically; while others take a bit more work. Thier diverity suprizes me.

