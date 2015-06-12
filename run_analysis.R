
run_analysis <- function() {
    # Merges the training and the test sets to create one data set
    features <- as.character(read.table("UCI HAR Dataset/features.txt")[,2])
    activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
    activity_labels[,2] <- as.character(activity_labels[,2])
    
    X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
    
    X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
    
    data_train <- cbind(X_train, y_train, subject_train)
    data_test <- cbind(X_test, y_test, subject_test)
    
    data <- rbind(data_train, data_test)
    
    # Extracts only the measurements on the mean and 
    # standard deviation for each measurement
    # find features names that contains mean() and std() as measurements
    grx1 <- glob2rx("*mean()*")
    grx2 <- glob2rx("*std()*")
    idx <- c(grep(grx1, features), grep(grx2, features))
    selected_cols <- features[idx]
    measurements <- data[,idx]
    
    # combine measurements with label and subject
    data <- cbind(measurements, data[,ncol(data)-1], data[,ncol(data)])
    
    # Appropriately labels the data set with descriptive variable names
    colnames(data) <- c(selected_cols, "label", "subject")
    
    # Uses descriptive activity names to name the activities in the data set
    data$label <- as.character(data$label)
    for (i in 1:nrow(activity_labels)) {
        data$label[data$label==activity_labels[i,1]] <- activity_labels[i,2]
    }
    
    # From the data set in step 4, creates a second, independent tidy data set 
    # with the average of each variable for each activity and each subject
    tidydata <- data.frame()
    
    for (i in 1:(ncol(data)-2)) {
        # aggregate the average result of each measurement 
        # over label and subject
        df <- aggregate(data[,1], list(data$label, data$subject), mean)
        # add a new column by repeating the column name
        df$var <- rep(names(data)[i], nrow(df))
        # rbind to the result data frame
        tidydata <- rbind(tidydata, df)
    }
    
    # rename tidydata column names
    colnames(tidydata) <- c("activity", "subject", "average", "variable")
    
    # return the tidy dataset
    tidydata
}


