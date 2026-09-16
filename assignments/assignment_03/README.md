Assignment 03 Readme file.

Joseph Busbin, 2026.09.16, assignment_03

Path to working directory
From SUPERCOMPUTING 
cd assignment
cd assignment_03
cd data/raw

and then...

In data/raw we find the raw data file (GCF_000001735.4_TAIR10.1_genomic.fna)
and under assignment_03 is the README file.
Laslty the tab seperated file in data/clean.

Task 1: Made a one line version of my script to setup my assignment directories. The same as assignment_01

Task 2: There are a few options to get files to download right on the HPC from command line: 
1. curl -O https://example.com/file.txt
2. wget https://example.com/file.txt

I used 'wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz' 
then to use the gunzip command you can just put the command and then the file name.
'gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz'

Task 3:
1. We use 'grep -c '>' filename  ; to count the number of sequence beginning line characters -- the '>'.
2. I tried 'grep -v '>' GCF_000001735.4_TAIR10.1_genomic.fna | grep -o -E '[ATCGUN]' | wc -l'
the '-v' flag signal those lines that do not start with or without the specified character for phase.
the '-o' flag prints only matching text. The '-E'flag will extend the regular expression
to look for all the characters in the file.
This did not work until I added the '-i' command as well to allow for case insensitivity giving:
'grep -v '>' GCF_000001735.4_TAIR10.1_genomic.fna | grep -o -E -i '[ATCGUN]' | wc -l'
3. This one is simple :) ' wc - l GCF_000001735.4_TAIR10.1_genomic.fna'
4. 'grep "mitochondrion" GCF_000001735.4_TAIR10.1_genomic.fna | wc -l'
5. 'grep '>' GCF_000001735.4_TAIR10.1_genomic.fna | grep 'chromosome' | wc -l'
6. 'grep -v '>' GCF_000001735.4_TAIR10.1_genomic.fna | head -n 3 |awk '{ print gsub(/[ATCGUNatcgun]/, "") }''
Becareful of the quotations used to denote the command and those used by awk.
The difference here is the we first sort out the non-sequence lines, then we get the count of any
characters from awk. gsub replaces any non-nucleiodtides with empty charaters so that awk 
the counts the right number.
Lastly the head -n 3 just takes the top three lines that we have gotten that are chromosome sequences.

7. 'grep -v '>' GCF_000001735.4_TAIR10.1_genomic.fna | grep 'AAAAAAAAAAAAAAAA' | wc -l '
This follows from above

8. 'grep '>' GCF_000001735.4_TAIR10.1_genomic.fna | sort -k 1.2'
Here the sort function take the output of the grep we are familiar with above, and then sort with 
the '-k' flag will sort numero-alphabetically the whole line specified by 1 with and offset of the
second character, put together '1.2' with a decimal/period

9. 'paste <(grep '>' GCF_000001735.4_TAIR10.1_genomic.fna) <(grep -v '>' GCF_000001735.4_TAIR10.1_genomic.fna) > tab_seperated_sequences.tsv'
With this command we just take the first set of columns that we want with '>' and use paste
to put them where we want literally specifing the columns order. Likewise with the second.
Then we put those to a new file. 

Then I wanted to move it to clean so I used " mv tab_seperated_sequences.tsv ../clean/"

I used nano to check the transfer worked.

Interlude: 
I have learned to not try to push a git to remote greater than 100 MB, it will not accept it. I then undid my commit.
To undo your commit use: git reset --soft HEAD~1
Then to unstage the file use: git rm --cached path/to/large/file.ext
Then to not push it again you have to add it to your git ignore: echo "path/to/large/file.ext" >> .gitignore
Only then should you try to re-commit the changes.

Reflection: 

My approach to learning these commands was to first think about what I was actually trying to get in the end. Often this looked like a series of filters narrowing down the content read from the file in to more and more refined streams. Then I would look up online the commands to do so and the way to formate them, then customize them to my file and file structure. I did actually use the –help flag on one of my functions in my work flow and that was cool.
I think what I learned is that there is a tool for everything and that there are multiple way to do the same task. You can do the same stuff with different tools, but they can go about it in different ways. As expected text parsing is very common. 
The ‘awk command surprised me, as being surprisingly versatile and deep in its applications. It is rich and like a language it self inside of Bash. 
These commands matter. Clearly this stuff can have a higher level of mastery and there is a higher skill cap than I at first though, as in the case of ’awk’ above sheer memorization the logic of the commands matters. Being able to know how much of what is in a file, sort and process it automatically are mandatory if you want to work at meaningful large scale. Besides it saves time. 
I don’t know if the logic of program could be perfectly automated. But if you knew the file structure and had a goal in mind you could replace the filename with a variable, and keywords of interest you were searching for with variables. These could be taken in as inputs to a script which could run all of these commands for you, for any file you like.
