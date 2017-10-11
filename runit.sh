#!/bin/bash

#Calls the python program to convert the first argument to a tab delimited file.
./space_tab.py $1

#Runs some code with R to convert tab delimited files to arff and csv files.
./script.r

#Runs some code with the Weka program to produce our results - the 
#algorithms and documentation is explained in other files.
./weka.sh
