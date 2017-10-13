#Author: William Jaros
#!/bin/bash

#Installs python
#If you don't have python:::
sudo apt-get install python3.6

#Installs the program R
sudo apt-get install r-base
#For installing R packages, R-base-dev package should also be installed::
sudo apt-get install r-base-dev

#If you don't have java:::
sudo apt-get install default-jre

#Downloads the zipped folder of the program Weka
wget http://prdownloads.sourceforge.net/weka/weka-3-9-1.zip
#git clone https://github.com/bnjmn/weka.git

#Unzips the Weka program
unzip weka-3-9-1.zip -d weka-3-9-1

#Removes the zipped folder to free space.
rm weka-3-9-1.zip
