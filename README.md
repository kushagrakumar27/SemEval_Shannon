About the Problem
(Author: Kushagra Kumar)

Our task is to identify the characters from the famous TV series Friends based on the multi-party dialogues. Specifically: for each token in a line of dialogue that refers to a person (I, you, woman, coworker, etc.), our task is to correctly identify the referent of that token.

The training data provided to us are the files friends.train.episode_delim.conll and friends.train.scene_delim.conll, such that first set of data is episode delimited while the second set of data is delimited on the basis of scene within each episode. Similarly, trial data files are friends.trial.episode_delim.conll and friends.trial.scene_delim.conll, delimited again on the basis of episodes and scenes, respectively but with less number of dialogues.


Our Approach
(Author: Marcus Walker)

Determining the referent of a token relies heavily on the context in which that token appears.  Context, here, refers not only to literal context such as the other tokens with which a token appears, but also to softer context, such as who is the .speaker. delivering the line in which the token appears.  Some degree of global context should also be implemented, checking such information as which characters have appeared in the episode or scene so far, and who is being referred to by other speakers using ambiguous referential tokens.

For the first stage of our approach, we chose to focus in on a method for classifying tokens to referents based on extremely local information.  If we can achieve reasonable accuracy with a myopic model, that gives us a solid foundation to build on by adding context: modeling local context will be analogous to language modeling (i.e., modeling sequences of tokens as a Markov chain), and adding broader and global context will remain a problem for us to have the pleasure of solving in the future.

Our myopic modeling is undertaken in three steps.

First, a .conll data file is converted to a tab-delimited text file using a replacement script in Python.  Variable lengths of white space are replaced with a tab character so that the data can be read by the same process that would read a .tsv (tab-separated values) file.  Tab is selected as a delimiter instead of the more common comma because some of the tokens in our data are commas, but none of them are tabs (though we.d love to see how such a line would be delivered by the actors!).

Second, the text file is read into an R data frame using R.  Once in the data frame, a variable denoting the token.s sentence.s ordinality in sequence is added, blank and marker (begin/end of document) rows are removed, and the class variable Entity ID (the referent of the token) is cleaned of superfluous characters,  This cleaned and updated data is then written to a tab-delimited .csv file (essentially the same as a .tsv), and also to a .arff (Attribution-Relation File Format) file, which is the preferred file format for classification in Weka.  This .arff file is used in our next step.

Third, the .arff file is read into Weka, and some filtering is done to ensure Weka sees the class variable Entity ID as a nominal attribute rather than a string.  Then, the real modeling begins!  Still interested in establishing a solid foundation that can be built upon, we use the J48 decision tree classification algorithm (see J48 algorithm section below) with default settings to classify the Entity ID of every referent token.  Rather than partition our trial data into a training and test set, we use ten-fold cross validation to gauge the accuracy of the model (see RESULTS-1 file).

J48 was chosen because it is a solid, vanilla decision tree algorithm that is easy to understand, and outputs a model that is similarly easy to understand.  This is in contrast to, say, Random Forest.  In our tests, Random Forest outperformed J48 slightly, but provided no insights that we could use, because it.s a wacky black box.  J48 is also very myopic, treating every instance as an independent observation, ignoring sequence and dependency between instances.  This allows us to build the context portions of the model without fear of the new techniques interacting unexpectedly with a model that is already attempting to capture contextual and sequential information.


J48 Algorithm
(Author: Marcus Walker)

J48 is a Java implementation of the general C4.5 decision algorithm.  Much like a language model, its essential mechanic is measure and comparison of entropy.  Rather than measuring the entropy of tokens based on conditional probability in a corpus, however, it uses a measure of entropy of the class variable (how uncertain is the classification of that variable) to choose data attributes and thresholds of those attributes. values to partition the data such that the difference in entropy (information gain) is maximized.

In other, possibly better, words: the baseline entropy of the class variable is found by just looking at the proportions of the classifications in the data.  Then, each attribute is evaluated for its ability to partition the data into subsets such that those subsets have lower entropy than the entire data set.  The attribute with the greatest such ability, or the most information gain, is selected and the data is partitioned into subsets according to its values.  Then, the process is iterated upon, using each of those new partitions as its own base set of data.  Once a point is reached, along each of these iterate branches, where no further partitioning results in a significant decrease in entropy, each leaf of that branch makes its best guess at how to classify the class variable.  

The result is a tree of conditional .checks. to make when classifying a new instance.  The value of the topmost partitioning attribute is checked, and the corresponding branch of the tree structure is explored.  At each node, this same check is performed, until a leaf is reached.  The classification from that leaf is applied to the instance, and voila!  Classification has been done!

Additional detail: using raw information gain (raw decrease in entropy) biases in favor of attributes with a high number of possible values.  This leads to problematic and inaccurate classifications in a lot of cases.  For that reason, J48 actually uses normalized information gain, which divides the raw information gain by the number of possible attribute values for that attribute.


Team Member Roles
(Author: Marcus Walker)

Our first, foremost, and shared role is that of excellent groupmate and committed, good-faith collaborator.  We toyed with the idea of one of us taking on the role of slouching layabout, but despite a strong tradition of such a division of responsibilities, we didn.t find it to be appropriate for our particular project.

William Jaros - Captain of Scripting, Packaging, and Managing

Shell scripting all of our disparate code fragments together
Packaging and management of shell scripts, documents, files
Fixing oodles of code and dependency disjoints
Input/Output and Program-Running documentation
Establishing and managing Git repository

Kushagra Kumar - Potentate of Python, Formatting, and Fixing Everything

Python scripting to convert .conll files to tab-delimited .txt format
Extensive troubleshooting in lieu of sleeping
Documentation of Problem Description and Third Party Tool
Troubleshooting again, because it deserves two bullet points

Marcus Walker - Mathemagician of Data Frames, Modeling, and Long-Windedness

R scripting to clean and format data for Weka
Weka scripting to generate classification model
Documentation of Approach, J48 Algorithm, Team Member Roles
Documentation of results analysis
Worrying about how much sleep Kush gets



Installing the Software
(Author: Kushagra Kumar)
Provide the relative path of the directory UMDuluth-CS8761-Shannon on your Linux machine, after extracting it from the tar file. Then execute the following command:

./install.sh

As per the install.sh, the installation step can be divided into five steps:
Installing python using:
sudo apt-get install python3.6

2.   Installing R  using:
sudo apt-get install r-base

3.   The zip folder for the third party tool Weka is obtained using either of the two methods:
wget http://prdownloads.sourceforge.net/weka/weka-3-9-1.zip
OR
git clone https://github.com/bnjmn/weka.git

4. This is followed by a call to unzip, which unzips Weka and creates a new directory weka-3-9-1, within the directory UMDuluth-CS8761-Shannon.
unzip weka-3-9-1.zip -d weka-3-9-1

5. Finally the zipped folder is removed using:
rm weka-3-9-1.zip

Running the Program
(Author: William Jaros)
The program can be run by navigating to the correct folder in command line and executing:

./runit.sh <EnterFileNameHere>

NOTE:

After running the above command, an error appears:



Open R by typing R in linux command line and give the command install.packages("data.table", dependencies=TRUE):



Then it asks to create a personal library for installing package, type .y. two times:



Select USA (IA) as the mirror:



All the packages would be downloaded. This takes some time.

Now run the command and it will produce all the required files:

./runit.sh <EnterFileNameHere>

Note: 	If more than one file needs to be run it will need to be run twice. The second file data will overwrite the first so changes to that will be changed in our future adjustments.


Expected Input/Output
(Author: William Jaros)

The expected input file should be a dialog separated word for word containing the following columns and data (It looks better in a text file with appropriate columns):

SeasonEpisode   Scene IDToken ID	WordForm	POS Tag 	Constituency Tag	Lemma   Frameset ID     Word Sense	Speaker Named 	Entity Tag	Entity ID       Sentence
/friends-s01e02 3   	0             	Man    		NN      	(TOP(S(NP*)     	man     -     		-    		Rachel_Green    *          	-
/friends-s01e02 3   	1               ,     		,       	*               	,     	-     		-    		Rachel_Green    *          	-
/friends-s01e02 3   	2               I   		PRP     	(NP*)           	I     	-     		-    		Rachel_Green    *      		(306)
/friends-s01e02 3   	3           	never   	RB     		(ADVP*)         	never   -     		-    		Rachel_Green    *          	-
/friends-s01e02 3   	4         	thought 	VBD     	(VP*            	think   -     		-    		Rachel_Green    *          	-
/friends-s01e02 3   	5               I   		PRP     	(SBAR(S(NP*)    	I     	-     		-    		Rachel_Green    *      		(306)
/friends-s01e02 3   	6             	'd    		MD      	(VP*            	would   -     		-    		Rachel_Green    *          	-
/friends-s01e02 3   	7              	be    		VB      	(VP*            	be     	-     		-    		Rachel_Green    *          	-
/friends-s01e02 3   	8            	here    	RB      	(ADVP*)         	here    -     		-    		Rachel_Green    *          	-
/friends-s01e02 3   	9              	..    		RB      	(ADVP*))))))))  	..     	-     		-    		Rachel_Green    *          	-

The data should include things like word form, POS Tag, Lemma, and speaker name.
Although, the data doesn't need to be tab delimited when input - I've included that here
so the data is more clear.


The expected output creates 5 files:

file1.arff
file1.csv
file1filtered.arff
file1J48results.txt
tab_delim_file1.txt

The expected output, predictions, model descriptions and accuracy reports are detailed 
in the results section.


Third Party Tool (WEKA)
(Author: Kushagra Kumar)
Waikato Environment for Knowledge Analysis (Weka), developed by the University of Waikato in New Zealand, is a collection of machine learning techniques used for real world data mining problems. Weka had been implemented in java. Weka comprises various tools for data clustering, pre-processing, regression, association rules and classification. It also includes visualization tools. 

Weka explorer is an environment for exploring the data provided as input. The input that weka takes is .arff file, which is generated through R as described in the second step of .Our approach.. In order to associate tokens like .I., .him., .she. with a certain Entity.ID, first the attribute .Entity.ID. needs to be converted from string to nominal as J48 (classifier in weka) only works on nominal attribute. Filters from weka are used for converting from one data type to another. We used unsupervised filter and then used the attribute option followed by selecting string to nominal. 

java -cp ./weka-3-9-1/weka-3-9-1/weka.jar weka.filters.unsupervised.attribute.StringToNominal -R 12 -i file1.arff -o file1filtered.arff

The above command was used to convert the file1.arff to file1filtered.arff such that file1filtered.arff has the attribute .Entity.ID. as nominal.  The .arff file comprises three main declarations: @relation, @attribute and @data. @relation tells about the relation name which in our case is:
@relation data2

@attribute tells about the ordered sequence of all the attributes with their corresponding values. In our case, it.s:
@attribute Speaker {'',All,Barry,Carol_Willick,Chandler_Bing,'Chandler,_Joey','Chandler,_Joey,_Phoebe,_Ross',Frannie,Joey_Tribbiani,Marsha,Monica_Geller,Paul,Phoebe_Buffay,Rachel_Green,Robbie,Ross_Geller,Susan_Bunch,Waitress}

@data tells indicates the start of the data segment in the file. Again, in our case it.s:

@data
/friends-s01e01,0,1,'\'s',VBZ,(VP*,be,-,-,Monica_Geller,*,?,?,?,?,?,?,?,?,?,?,?,?,?,1
/friends-s01e01,0,2,nothing,NN,(NP*,nothing,-,-,Monica_Geller,*,?,?,?,?,?,?,?,?,?,?,?,?,?,1
/friends-s01e01,0,3,to,TO,(S(VP*,to,-,-,Monica_Geller,*,?,?,?,?,?,?,?,?,?,?,?,?,?,1

Finally, the data in file1filtered.arff is run through 10-fold cross-validated J48 (classifier in weka) with default settings, classifying Entity.ID. The result with the percentage of correctly identified tokens (like I, him, her) are outputted to file1J48results.txt using the command:

java -cp ./weka-3-9-1/weka-3-9-1/weka.jar weka.classifiers.trees.J48 -t file1filtered.arff -x 10 -c 12 > file1J48results.txt











