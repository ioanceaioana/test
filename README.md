Getting and Cleaning Data

Project: 

Create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Steps to work on this course project

Data source must be allready dowloaded in working folder on your local drive.  

Put run_analysis.R in the working folder with the dataset, then set it as your working directory using setwd() function in R/RStudio.
Run source("run_analysis.R") command, this will generate a new file named tiny_data.txt in your working directory.

Dependencies

run_analysis.R script will help you install the dependencies library automatically.( It depends on (reshape2 and data.table).