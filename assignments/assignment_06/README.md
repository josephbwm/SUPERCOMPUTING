##README for assignment_06

### 1.  Setup assignment_6/ directory
	Cleaning up the directory and making it match took a while. 

### 2. Download raw ONT data
	I learned a new flag while writing this script, the "-P" flag on wget 
	will accept a file path to place the download rather than having to move 
	it afterwards or doing in your current location. 
	Other than that, I added a .gitignore for data to make life better.
	I had to go back to unpack the file.
	Coming back to this on testing, the nodes don't have wget, they do 
	have curl. Find that out the hard way changed how I wrote the download 
	script.

### 3. Get Flye v2.9.6 (local build)
	I tried the local build with using git clone to place the clone into programs 
	however that is not working for reasons I do not understand
	I then moved to programs and then proceeded to install, and was
	subsquently logged out of bora... for reasons I do not know why...
	but Flye installed, so not a problem I guess? 
	This was a confusing part of the process for me.

### 4. Get Flye v2.9.6 (conda build)
	So I have run into a similar situation here. It would appear that
	while my script has functioned, and flye appear to be installed, I am 
	skeptical at best given the ominous error message that the download 
	process showed it overcame. That said, it worked cleanly otherwise.
	I think that the script provided by the assignment might be a little out
	of data because I though we used "eval "$(conda shell.bash hook)"" to 
	allow conda into the shell, not the other version found in the assignment
	document.

### 5. Figuring it out (on the Flye)
	coliphage genome size range from 3.39 kb to over 386 kb.
	This is 52.9M bases or 52.9kb so there could be just one or multiple
	genomes in this file. And the idea that they could not all be the
	coliphage suspected is frightening. 
	To be a 'good citizen' I tried to limit the given number of threads that 
	I would use. However I didn't understand how to do that until I saw
	the usage doc "-t int, --threads int"  
	Looking at what the FAQ for flye says, it specifies that for a phage 
	genome it takes roughtly 30 minutes on 30 threads. So whatever functionality
	that is, I will not be trying it on the login node.
	I read the README and usage docs. 
	Our piece of data is Oxford Nanopore, and we need to check the fastq header
	into order see which tpye of chemistry was used (R10,R9,R7 or older).
	But since it is current standard we cna assume R10, and thus use 
	`--nano-hq`. 
	I tried to use " flye --nano-hq test_phage_data.fastq --out-dir
	subset_test -t 2" to run an a test set of data, and it gave me:
	"ERROR: samtools is not installed" which is as far as I am willing to 
	take it right now. 
	Came back, found how to load it from module, feeling good about giving it a try.
	Gave it a try on the test data, it ran, errored as expected, but it ran! 
	My command should start like:
	"flye --nano-hq ./data/SRR33939694.fastq --out-dir ./results -t 6"
	ran from the assignment_06 directory. 

	Making futher o assemble possible multiple of organisms (one or more phage), we include the 
	--meta tag, this one is essential.
	To account for the small size of phage genomes we use: --min-overlap 1000.
	The final command is then  
	"flye --nano-hq ./data/SRR33939694.fastq --out-dir "${OUT}" ./results -t 6 --meta
	--min-overlap 1000"
	I'm just not brave enough to run it on the log in node.

### 6. Run Flye, 3 ways (gonna Flye now)
	a) I find the find command to be continually useful. 
	b) I am starting to see the point of this assignment. As I construct
	one script I make assumptions, that only when making the next version 
	do I realize that I have made, go back and fix the previous script while 
	trying to make the next. So I am correcting my understanding as I make 
	the variations of the doing the same thing three different ways. 
	
	c) The local was the easiest, maybe thats just because it was the last
	I added and extra check for the PATH, and the added it to PATH just in 
	case.
	
	In trying to test my scripts I keep getting kicked off the login in node,
	so I will have to build a batch script to get it to work for any of them.
	
	I learned an important lesson about file paths, when I deleted a lot of
	my work all at once when trying to clean up. A reminder to be aware of 
	your current working directory.
	The good news that the scripts are running quite well otherwise.
	
### 7. Compare the results in the log files
	The code I used was simple it just looked like:
	"tail -n 10 "./assemblies/assembly_<conda, module, or local>/*.log" " 
	then to check them all we can put them in a for loop! 
	
	In the interium I was brave enought to try to run some of my scripts,
	and predictably go kicked off multiple times, until I realized that
	many of the problems I was facing (flye local build, test_toy, flye
	usage) were all because the process were interupted. So to run a 
	number of my scripts I need to submit them as a job. 

### 8. Build a `pipeline.sh` script
	Pretty easy seeming to put together, it's nice to all the parts in one,
	but I now have hte problem that I can't run it without turning it into 
	a SLURM job. A problem for another day. 

### How to run the pipeline: Call "pipeline.sh" from the assignment_06 directory
	inside of a submitted job to SLURM to not overrun the login node.
	- Make sure you have the required modules on your HPC (miniforge, flye, etc.)
	- Make sure sure you have a "~/programs" directory for Flye to install into.

### 9. Delete everything
	For this the rm -rf <filepath> comes in handy!
	
### Reflection:
	The biggest challege for me was not having the scripts and programs 
	run properly because I got kicked from the login node. That ended up 
	confusing me a number of times. 
	As an addendum, I have tested the job on the HPC nodes rather than
	the login and there were many particularies that were not displayed
	in the examples I did before. A lot of bug stomping.
	I learned, and delighted in doing so, that taking multiple approaches
	to constructing the same functionality while have advantages and 
	disadvantages of thier own, can also teach you something deeper 
	about each individual task and question the core assuptions about 
	how each approch works. It shows you how each acomplishes the same 
	goal. 
	I think that I actually prefer local instilation. It is slower, and 
	takes some time to set up. But if this is software that I relying on
	I want to be in control of it. I think my opinion might be different
	however if I went through the process of them trying to make my 
	version (which is nicely tuned to me) now work for someone else.
	I can see how that would be a detering barrier. 
	Conda enviroments appeal to me as a good middle ground after clearing up
	more confusion about how it works.
	For next assignment I think I will go for the conda env, just because
	as I said, I think it has a good balance, and is good to get used to.

	
	

 


