Coursera
========

Code for Coursera class "getting and cleaning data"

In order to work, this script needs to be located in the same folder as the files "activity_labels.txt" and "features.txt" as well as folders "test" and "train".

The code runs the following way:
- Reads the variables names for the X datasets and prepares a vector containing the indices of the variables we wish to retain. Those variables have names containing the pattern "-mean()" or "-std()". The vector is created using the classic function grep.
- Reads the 2 X datasets (test and train) and subsets them straight away to avoid overloading memory
- Reads the "subject" and the "y" ("activity") datasets (both consist in a column vector), the appends them to the 2 X datasets
- Merges the 2 datasets thus obtained
- Creates a new column that contains an explicit activity name. This is obtained by merging our dataset with another dataset containint a column "ActID" and the associated name. By default the "merge" function will work on that variable. We then discard that "ActID" variable so as not to be bothered by it during the next steps.
- Finally, we use the reshape2 package as explained in lecture 4 of week 3, with the "melt" and "dcast" functions, to obtain the required dataset.
- The dataset is then written into a text file.
- Enjoy!
