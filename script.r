#!/usr/bin/Rscript

# The following R code is designed to clean and format the data in preparation for throwing it into Weka.
# Files (assumed to be tab-delimited) are read into R data frames.  Instances, corresponding to individual
# tokens, are ordinally labeled according to the sentence they belong to.  Blank and marker instances are
# discarded.  The class variable (Entity.ID) is cleaned of extraneous characters.  Finally, the data frame
# is written out in both .csv and .arff format, the latter being the preferred format for Weka classification.

# Enable libraries
library("data.table")
library("stringr")
library("foreign")

# Reads in txt file as a tab-delimited "csv-as-far-as-R-is-concerned" file with headers
# (Assumption: the txt file has been converted to tab-delimited format)
data <- read.csv("file1.txt", header=TRUE, sep="\t")
# Label each sentence in the file with a sentence number so that blank rows can be
# removed without loss of information
j = 1;
for (i in 1:nrow(data)){
  if (data$SeasonEpisode[i] == ""){
    j = j + 1;
  }
  data$Sentence[i] = j;
}
# Discard blank rows and rows containing only begin/end of document markers
data2 <- subset(data, SeasonEpisode != "")
data2 <- subset(data2, SeasonEpisode != "#end document")
data2 <- subset(data2, SeasonEpisode != "#begin document")
# Clean Entity.ID of extraneous characters
data2$Entity.ID <- str_extract(data2$Entity.ID, "[[:digit:]]+")
# Write to both a csv and an arff (the latter format for Weka)
write.csv(data2, file="file1.csv", row.names=FALSE)
write.arff(data2, file="file1.arff")

# Repeats above process exactly, with second file
data <- read.csv("file2.txt", header=TRUE, sep="\t")
j = 1;
for (i in 1:nrow(data)){
  if (data$SeasonEpisode[i] == ""){
    j = j + 1;
  }
  data$Sentence1[i] = j;
}
data2 <- subset(data, SeasonEpisode != "")
data2 <- subset(data2, SeasonEpisode != "#end document")
data2 <- subset(data2, SeasonEpisode != "#begin document")
data2$Entity.ID <- str_extract(data2$Entity.ID, "[[:digit:]]+")
write.csv(data2, file="file2.csv", row.names=FALSE)
write.arff(data2, file="file2.arff")
