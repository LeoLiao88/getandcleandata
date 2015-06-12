# getandcleandata
Submission of course project to getting and cleaning data Courera

The run_analysis.R code follows these steps:

(1) Merges the training and the test sets to create one data set
    * read the files from “UCI HAR Dataset” folder saved in the working directory
    * combine the columns separately for training and testing data
    * combine the rows of both training and testing data

(2) Extracts only the measurements on the mean and standard deviation for each measurement
    * find the index of features names that contains mean() and std() as measurements
    * combine measurements with label and subject columns
 
(3) Appropriately labels the data set with descriptive variable names

(4) Uses descriptive activity names to name the activities in the data set

(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
    * aggregate the average result of each measurement over label and subject
    * add a new column by repeating the column name
    * rbind to the result data frame
    * after looping through all measurements, rename tidydata column names as "activity", "subject", "average", "variable"
    * return tidy data
		