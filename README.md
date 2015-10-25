The R script named "run_analysis.R" reads the original 
train and test data sets provided in "UCI HAR Dataset" directory where was downloaded from:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

First, X, Y and the subject IDs were combined together to form the training and testing data sets separately (DATA_train and DATA_test). 

In the next step, the train and test data sets were 
combined together by the subject IDs.  The columns containing the "mean()" and standard deviation "std()"
were extracted. 

In order to make the dataset more readable the activity 
labels of 1-6 were substituted with their descriptive values from the data provided in "activity_labels.txt". 

Using the cleaned data at this point a new data set was generated where each row is the average of different measurement variables for each subject and for each activity. 

The resulted cleaned data was written to a text file named "TidyDataStep5.txt". 

A description of the varibales can be found in CodeBook.md.
