#!/bin/bash 
set -ueo pipefail

#install_seqtk.sh

#Get file
git clone https://github.com/lh3/seqtk.git;
cd seqtk; make

#The above unpacked the file, but now we sit in a subdirectory,
#which is file we just have to make sure to add the subdirectoy to the path 
#and then we should have PATH access to all the files in said subdirctory including 
#the seqtk file we desire.
#In a way it is much simpler.

#Add to PATH
echo "export PATH=$PATH:~/programs/seqtk" >> ~/.bashrc
