#Author: William Jaros
#!/bin/bash

#Calls the python program to convert the first argument to a tab delimited file.
#python space_tab.py $1

#Runs some code with R to convert tab delimited files to arff and csv files.
#If an error is encountered saying "there is no package called data.table" then run these commands:
#R (opens up R command line interface)
#install.packages("data.table", dependencies=TRUE)
#Refer to README under "Running the program" for detailed explanation:

#./script.r

#Runs some code with the Weka program to produce our results - the
#algorithms and documentation is explained in other files.
./weka.sh
