---
title: "CodeBook.md"
author: "R.Hunnicutt"
date: "August 24, 2014"
---

## Descriptor (Dimension) Variables

|variable|type|source|translation|
|-----------|----|-----------------------------|-----------|
|SubjectID  |int |subject_xxx.txt data files   |none       |
|ActivityID |int |activity_labels.txt          |none       |
|Activity   |chr |activity_labels.txt          |none       |

_Please Note:_
Detailed documentation including values can be found in the documentation provided in the UCI HAR Dataset.

## Feature (measure) Variables
Detailed documentation concerning the Features data can be found in the features_info.txt file located in the UCI HAR Dataset folder.

### Feature variables translation
run_analysis.R loads the feature variables from the features.txt file.  It then creates a logical vector with the value of TRUE for each occurance of mean() or std() in the feature name.  This vector is used in various places within the script to denote the columns that will be in the final dataset.
```
features.logical<-grepl("mean()|std()",features)
```
```
X_test<-X_test[,features.logical]
```


In the output file tblUCI_MeansValues, the script utilzes melt() and dcast() functions to provide the average of each variable for each activity and each subject.

```
idLabels<-c("SubjectID", "ActivityID", "Activity")
dataLabels<-setdiff(colnames(tblUCI_tidy),idLabels)
meltUCI<-melt(tblUCI_tidy, id = idLabels, measure.vars = dataLabels)
tblUCI_MeanValues<-dcast(meltUCI, SubjectID + Activity ~ variable, fun = mean)
```

_No other data translations occur in the script._
