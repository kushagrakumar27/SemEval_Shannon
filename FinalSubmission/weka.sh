#Author: Marcus Walker
# The following code calls Weka to run our data through a J48 algorithm to classify Entity.ID, our class variable
# which identifies the person being referenced by a relevant word in a line of dialogue.  The output is written to
# a text file, which includes measures of accuracy as well as the confusion matrix.  Fun!

# Run the data through 10-fold cross-validated J48 with default settings, classifying Entity.ID
# Write the results to text files instead of printing them, because we are not the villains we may fear to become
# README Steps 14 & 15
  java -cp ./weka-3-9-1/weka-3-9-1/weka.jar weka.classifiers.trees.J48 -t file1filtered.arff -x 10 -c 12 > file1J48results.txt
# java -cp ./weka-3-9-1/weka-3-9-1/weka.jar weka.classifiers.trees.J48 -t file2filtered.arff -x 10 -c 12 > file2J48results.txt