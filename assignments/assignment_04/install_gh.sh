#!/bin/bash 
set -ueo pipefail

#install_gh.sh
#Expection: the ~/programs directory already exists.

#Get file
wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

#Unpack file
tar -xzvf gh_2.74.2_linux_amd64.tar.gz -C ~/programs

#Clean up old file
rm gh_2.74.2_linux_amd64.tar.gz


#For unpacking: mkdir -p ~/programs && tar -xzvf gh_2.74.2_linux_amd64.tar.gz -C ~/programs
#would be a better version provided you did not know if the directory already existed.
#In the case it does not I find it better practice to fail than to make directories the
#user does not expect. 
