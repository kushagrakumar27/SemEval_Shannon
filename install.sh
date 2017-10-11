#!/bin/bash

#Installs the program R
sudo apt-get install r-base

#Downloads the zipped folder of the program Weka
wget http://prdownloads.sourceforge.net/weka/weka-3-9-1.zip
#git clone https://github.com/bnjmn/weka.git

#Unzips the Weka program
unzip weka-3-9-1.zip -d weka-3-9-1

#Removes the zipped folder to free space.
rm weka-3-9-1.zip
