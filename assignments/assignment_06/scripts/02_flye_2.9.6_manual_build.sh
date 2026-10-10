#!/bin/bash

set -ueo pipefail

#flye_2.9.6_manual_build.sh
#script designed to download flye for genome assmbly 
#build in ~/programs/ (requires a programs folder) 

#local building (wihout installation)
#move to the location
cd ~/programs

#install
git clone https://github.com/fenderglass/Flye

cd Flye

make

#availibe as python bin/flye

#test installation was successsful
python flye/tests/test_toy.py


#Add to path 
export PATH=$PATH:~/programs/Flye/bin
