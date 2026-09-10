Assignment 02 Readme file.

Joseph Busbin

2026.09.10

assignment_02

Data files were added to data/raw

Local FNA md5sum hash:c13d459b5caa702ff7e1f26fe44b8ad7

Local GFF md5sum hash:0f52ffc94af5ddf544ff89cc6f546b0c

HPC FNA md5sum hash:c13d459b5caa702ff7e1f26fe44b8ad7

HPC GFF md5sum hash:0f52ffc94af5ddf544ff89cc6f546b0c

Verified the same! 

assignment_02 Bash Aliases:
aliases added: 
	- 'u' for up
	- 'd' for down
	- 'll' for long list
"cd" is change directory
".." is the parent path
";" allows you to concatinate multiple commands onto the same line
"clear" clears the screen
"pwd" gives the working directory
"-a" on ls command gives all files
"-l" on ls command list the files in long format
"-F" on ls command is to give indicator on files for readbility
"-h" on ls command shows human readable file sizes
" --group-directories-first" on ls command to sort and display folder before files

File download commands:
sftp ftp.ncbi.nlm.nih.gov
entered anonymous and email
sftp commands: "get", "put", and "bye" are used to download files, upload files, and log out

File upload:
Used FileZilla to upload files to HPC

bash commands:
"chmod a+r filename" changes the file to world readable (gives access)

Check file hash:
Just use 'md5sum filename' to get the hash of a file in local directory.

assignment_02 learnings: ALWAYS git pull, git add, git commit, git push.


assignment_02 Bash Aliases:
aliases added: 
	- 'u' for up
	- 'd' for down
	- 'll' for long list
"cd" is change directory
".." is the parent path
";" allows you to concatinate multiple commands onto the same line
"clear" clears the screen
"pwd" gives the working directory
"-a" on ls command gives all files
"-l" on ls command list the files in long format
"-F" on ls command is to give indicator on files for readbility
"-h" on ls command shows human readable file sizes
" --group-directories-first" on ls command to sort and display folder before files

assignment_02 bash commands:
"chmod a+r filename" changes the file to world readable (gives access)
sftp commands: "get", "put", and "bye" are used to download files, upload files, and log out

Reflection:
I really scared my self at some points just because I realized that i
might not be following proper git procedure. So a continued learning for me
is to ALWAYS git pull, git add, git commit, git push.
A hard part for me was the sftp as the file transfer shell was new
and different. I had to try a number of times to download the files.
This is probably because I am far less familiar with servers.
FileZilla worked really well, it is super easy and saves on typing.
If I could I would change this so that it all worked in FileZilla where
I could nicely see everything that happend in the shell and change
permission there too. Only thing is I don't know if you can preform git
actions from there as well. 
