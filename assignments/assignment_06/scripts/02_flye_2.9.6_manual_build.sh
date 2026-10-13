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

#Add to path
export PATH=$PATH:~/programs/Flye/bin

#test installation was successsful
python3 flye/tests/test_toy.py
