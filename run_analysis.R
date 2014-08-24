## Create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Load Required Packages
if (!require("data.table")) {install.packages("data.table")}
require(data.table)

if (!require("reshape2")) {install.packages("reshape2")}
require(reshape2)

## Download data
work.dir<-getwd()
if(is.null(work.dir)) {
  setwd()
  work.dir<-getwd()
}
if(!file.exists("./UCIdata")){dir.create("./UCIdata")}
setwd("./UCIdata")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "UCI_HAR_download.zip", method="curl")
unzip("UCI_HAR_download.zip")
dateDownloaded <- date()
dateDownloaded

## Load applicable tables
actLables<-read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features<-read.table("./UCI HAR Dataset/features.txt")[,2]

## Locate mean and std. deviation features
features.logical<-grepl("mean()|std()",features)


## ---------------------- Test

# Load  X_test, y_test and subject_test data
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test)<-features

# Extract the mean and std. deviation variables
X_test<-X_test[,features.logical]

## Add activity lables and variable names to y_test and subject_test
y_test[,2]<-actLables[y_test[,1]]
names(y_test)<-c("ActivityID", "Activity")
names(subject_test)<-c("SubjectID")

## Combine _test tables
tblTest<-cbind(as.data.table(subject_test), y_test, X_test)

## ---------------------- Train

# Load  X_train, y_train and subject_train data
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train)<-features

# Extract the mean and std. deviation variables
X_train<-X_train[,features.logical]

## Add activity lables and variable names to y_train and subject_train
y_train[,2]<-actLables[y_train[,1]]
names(y_train)<-c("ActivityID", "Activity")
names(subject_train)<-c("SubjectID")

## Combine _test tables
tblTrain<-cbind(as.data.table(subject_train), y_train, X_train)

## ---------------------- Combine Tables

## Combine test and train data
tblUCI_tidy<-rbind(tblTest,tblTrain)

## Create second tidy data set of means
idLabels<-c("SubjectID", "ActivityID", "Activity")
dataLabels<-setdiff(colnames(tblUCI_tidy),idLabels)
meltUCI<-melt(tblUCI_tidy, id = idLabels, measure.vars = dataLabels)
tblUCI_MeanValues<-dcast(meltUCI, SubjectID + Activity ~ variable, fun = mean)


#Reset work directory
setwd(work.dir)

## Write tidy files to user's work directory
write.table(tblUCI_tidy, file = "tblUCI_tidy.txt",quote=FALSE,sep=",",row.names = FALSE)
write.table(tblUCI_MeanValues, file = "tblUCI_MeanValues.txt",quote=FALSE,sep=",",row.names = FALSE)
