############
############Getting and cleaning data project
############
###Read features used for each subject in both train and test data sets
features <- read.table("./UCI HAR Dataset/features.txt") #dim 561X2
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt") # label of the activities
####Read the training data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #dim 7352x1
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt") #dim 7352X561
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") #dim 7352X1
DATA_train <- data.frame(subject_train, Y_train, X_train)
ColNames <- c("subject_train", "Y_train", as.character(features$V2))
####Read the test data 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") #dim 2947X1
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") #dim 2947X561
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") #dim 2947X1
######
######creating a data frame for with test data
DATA_test <- data.frame(subject_test, y_test, X_test)
ColNamesTest <- c("subject_test", "Y_test", as.character(features$V2))
######
######Section 1, the data are merged and the name of coloumns were changes using the feature names
AllData <- merge(DATA_train, DATA_test, by.x = "subject_train", by.y = "subject_test")
AllData <- rbind(DATA_train, DATA_test)
ColNamesTest <- c("subject", "activity", as.character(features$V2))
colnames(AllData) <- ColNamesTest
######
######Extract measurements containing mean() or std()
MeanStdCols <- grep("mean()|std()", names(AllData))
Data2 <- AllData[, MeanStdCols]
Data2 <- cbind(AllData[,1:2], Data2)
######
######Change the name of activity with the list in the feature
for (kk in 1:dim(activity_label)[1]){
  Data2$activity[Data2$activity==kk]=as.character(activity_label$V2[kk])
}
######
######arrange the data based on the subject 
library(dplyr)
Data3<-arrange(Data2, subject) # arranging the data
######
######Calculate average of each column for for the ordered data and create a new data set
CleanDATA <- c()
for (ii in unique(Data3$subject)){
  for (jj in unique(Data3$activity)){write.table(CleanDATA, "TidyDataStep5.txt", row.names = FALSE)
      BB <- filter(Data3, subject==ii & activity==jj)
      DATA <- data.frame(subject=ii, activity=jj, as.list(colMeans(BB[, 3:dim(Data3)[2]])))
      CleanDATA <- rbind(CleanDATA, DATA)
  }
}
write.table(CleanDATA, "TidyDataStep5.txt", row.names = FALSE) 
####


