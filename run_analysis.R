rm(list = ls())
filename <- "getdata_dataset.zip"
if (!file.exists(filename)){
  download.file(url = paste("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                            sep = ""), 
                destfile = filename, mode = 'wb',cacheOK = FALSE)
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
##Extracts only the measurements on the mean and standard deviation for each measurement

featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

test <- cbind(testSubjects, testActivities, test)
##Merges the training and the testing data sets to create one data set

CombinedData <- rbind(train, test)

colnames(CombinedData) <- c("subject", "activity", featuresWanted.names)
##Convert activities & subjects into factors from activityLabels

CombinedData$activity <- factor(CombinedData$activity, 
                                levels = activityLabels[,1], 
                                labels = activityLabels[,2])

CombinedData$subject <- as.factor(CombinedData$subject)
##Convert Combineddata into a molten data frame

library(reshape2)
## Warning: package 'reshape2' was built under R version 3.2.3
CombinedData.melted <- melt(CombinedData, id = c("subject", "activity"))
CombinedData.mean <- dcast(CombinedData.melted, 
                           subject + activity ~ variable, mean)

write.table(CombinedData.mean, file = "TidyDataSet.txt", 
            row.names = FALSE, quote = FALSE)

