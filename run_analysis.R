## Task ; Create one R script with the name "run_analysis.R" that does the following:
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive activity names.
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#install data.table
if (!require("data.table")) {
  install.packages("data.table")
}


#install reshape2 
if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")


# read activity labels from file
activity_labels <- read.table("activity_labels.txt")[, 2]


# read column names from file
features <- read.table('features.txt')[, 2]


# remove parentheses () in column names
features <- gsub('[()]', '', features)


# read test data from file
test_x <- read.table('test/X_test.txt')
test_y <- read.table('test/y_test.txt')
test_subject <- read.table("test/subject_test.txt")


# read train data from file
train_x <- read.table('train/X_train.txt')
train_y <- read.table('train/y_train.txt')
train_subject <- read.table("train/subject_train.txt")

names(test_x) <- features
names(train_x) <- features


# filter only column names with suffix "-mean" or "-std" 
extract_features <- grepl("-mean|-std", features)


# subset data from those column names
test_x <- test_x[, features[extract_features]]
train_x <- train_x[, features[extract_features]]

# map activity labels into column next to of activity IDs
test_y[, 2] <- activity_labels[test_y[, 1]]
train_y[, 2] <- activity_labels[train_y[, 1]]

names(test_y) <- c("activity_id", "activity_label")
names(train_y) <- c("activity_id", "activity_label")

names(test_subject) <- "subject"
names(train_subject) <- "subject"


# put "subject" into  column 1st, and Y into  column 2nd of our dataset
test_data <- cbind(as.data.table(test_subject), test_y, test_x)
train_data <- cbind(as.data.table(train_subject), train_y, train_x)


# merge test and train data
data <- rbind(test_data, train_data)


# define what columns will be ID and what contain variables
id_labels <- c("subject", "activity_id", "activity_label")
data_labels <- setdiff(colnames(data), id_labels)


# melt data putting all measurements as groups 
melt_data <- melt(data, id = id_labels, measure.vars = data_labels)


# Apply mean function to dataset
tidy_data = dcast(melt_data, subject + activity_label ~ variable, mean)


# Store data in text file.
write.table(tidy_data, file = "tidy_data.txt")