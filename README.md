# Getting-and-Cleaning-Data

This project is to prepare a tidy data set for later analysis from the experiment data available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The main procedure is as following:

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Here is how my script implements:

Clean current workspace. Set up the working directory.
Download the data set to working directory from the target URL. Unzip the file.
Load the activity labels and features. Select the features including mean and standard deviation and assign the values to “features_need”.
Load the data for test and train including subject, activity and experiment result. Select columns matching “features_need”.
Combine the subject, activity and experiment result for test and train respectively and get the data sets “train” and “test”.
Merge “train” and “test” to get “mergeddata”.
Clean the special characters in “features_need”. Rename column names in “mergeddata” using “features_need”.
Use descriptive activity names to name the activity column in “mergeddata”
Take the average of each variable in “mergeddata” for each activity and each subject. Assign the value to a new data set “summary_data”. Write the output.
