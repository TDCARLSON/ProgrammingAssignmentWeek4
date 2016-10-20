
# Getting and Cleaning Data - Course Project

This is the Week 4 course project for the Coursera Getting and Cleaning Data class.
The R script, `run_analysis.R`, does the following:

1. Downloads the data
2. Combines training and test data
3. Extracts only those columns which have a mean or standard deviation
4. Convert the labels using their descriptive activity names 
5. Binds the subject and activity columns to create one combined tidy dataset
6. Creates a second tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

Dataset: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

`CodeBook.md` describes the variables, the data, and any transformations or work that was performed to clean up the data.
Output files are 'tidydata.txt' and 'tidydatameans.txt'.