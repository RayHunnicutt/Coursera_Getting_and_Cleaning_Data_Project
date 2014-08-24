---
title: "ReadMe.md"
author: "R.Hunnicutt"
date: "August 24, 2014"
output: html_document
---

#run_analysis.R
A course assisngment for the Coursera Getting and Cleaning data class.

##Assignment
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project: 

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Script requirements
This script requires two libraries, data.table and reshape2.  If these are not present, then the script will install and load these packages.

## Methodology
The steps are documented directly in the script.  In summary:
1) Confirm required libraries are present.  Install and load as necessary.
2) Set working directory and download data
3) Load descriptor tables.  These will become the variable names in the final output.
4) Create _test table from components extracting only mean and std variables.
5) Create _train table from components extracting only mean and std variables.
6) Combine test and train data into the first tidy dataset (tblUCI_tidy)
7) Create second tidy data set of means (tblUCI_MeanValues).  The chosen method utilizes melt() and dcast().
8) Reset work directory and write tidy files to user's work directory.

## Table Connectivity
Once decompressed, there are two descriptor tables in the root directory (UCI HAR Dataset).
1) activity_labels.txt provides label names for the various activitiies monitored.
2) features.txt provides column names for the variables in the xtest and xtrain data       files. For a full explanation of all features, see features_info.txt in the root directory (UCI HAR Dataset).

The folders test and train contain the data files utilized by this script.
1) subject_xxx.txt provides the subject ids.
2) X_xxx.txt provides the features data.
3) y_xxx.txt provides the activity ids

## License information
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.