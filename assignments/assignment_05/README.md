##README for assignment_05

###Task 1: 
	I found it was simple :) 
###Task 2:
	-First I learnt tar commands and that -xf {filename} -C {destination} could get 
		my files where I wanted them to go in one step.
	-However I ran into an issue that the files that it moved where of the format
		fastq.gz, not just fastq. Looking up what that was the .gz means that it is 
		still gunzip compressed. Not fun so had to go back to change that.
	-To remove all files in a directory but not the directory itself use: 
		rm -rf /path/to/directory/* or rm -rf ./* depending on current location
	-I was going to use "find ./data/raw -name "*.fastq.gz" -exec gunzip {} +"
		in my script to transform the gzip files in plain fastq. 
		But as it turns out we don't need to for script 2 to do it's job.
		I will still leave my learning here for later:
		it is pretty clear what this line does
		'{}' means the current file that find has located.
		'+' means that tells find to group all of the files it discovers and submits
		them to through the '-exec' command to gunzip all in one batch rather than 
		individually.
		And alternative with a for loop would look like:
		for FILE in *fastq.gz; do gunzip ${FILE}; done
	-I added a reload command into my .bashrc, so that I could easly refresh the PATH
		or any other variables
	
###Task 3:
	Found the pre-compiled binary for linux and instructions. I did 
	it by hand because it was so simple. 
	Then to add it to my path I used "export PATH=$HOME/programs:$PATH" and put 
	that into my .bashrc, that seemed to work after refreshing the bash terminal.
	Looking at the help I learned a few things:
		-Generally I thought I noticed that --name stands for a file name or directory, as 
		they occur after flags like -i and -o. I have seen this in other uses, but 
		it turns of that "--" means bare and actually denotes that anything after
		it should be treated as a positional argument rather than a contiunation of 
		a command line option as was started by the flag. It is a delimitor, not an
		addition to the flag. (At least I learnt this is generally what it means)
		- I read through the help page and I feel like it has more options than
		some of the other tools we have used. That said I am still unsure of what 
		thier use case would be.
		
###Task 4:
	My approch was to use the hint with the search and replace followed by
	just putting all of the command options on fastp on across seperate lines.
	Then the test file I used was 6083_001_S1_R1_001.subset.fastq.gz. 
	
	Of course the one mistake I made was a file path error, and did tried to direct 
	it the file name "6083_001_S1_R1_001.subset.fastq.gz" rather than "data/raw/6083_001_S1_R1_001.subset.fastq.gz"
	where the actual file could be found.
	
###Task 5:
	On starting this task it looks like it started to come together, but then I thought
	about what we were doing with this output? Should it be piped to trimmed somehow? 
	I don't think I got a file out of this however. It might be overwriting my reads without 
	me knowing it... Oh, nevermind I see were in script two it is already adressing my concerns
	inside of the search and replace that is being used for the outputs! 
	
###Task 6:
	To remove all the fiels I used data/raw/* to clear all the files 
	in the directory. 
	My first time failed as I forgot a / in one of my paths to the second 
	script. I had to delete again.
	The second time seemed work great! 
	
###Clean up:
	To push to git, I just added the whole of the data directory 
	into my .gitignore. As "data/"
	```
	#.gitignore
	#in assignment_05 directory
	touch .gitignore 
	echo "data/" >> .gitignore 
	```

###How to use pipeline.sh:
It requires the a directory structure with data/raw and data/trimmed, along with
a scripts folder scripts, and the associated scripts in runs in that foler.
It in intented to be run from the directory containing both the data and scripts
directories.
Upon execution it takes not postional arguments, downloads relevent files, and 
trims them to certain specification.

###Reflections:
I learned a lot about how to clean up a lot of files at once, and how to undo
the mess that a script can make. I also learned something important and knowing 
what file types your programs are expecting.
I see the pros and cons of the spiting of the script as a modularization of the 
code, something taken from software development class.

