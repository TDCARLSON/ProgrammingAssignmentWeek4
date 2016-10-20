##Working Directory
work_dir <- "C:/Coursera/Getting and Cleaning Data/ProgrammingAssignmentWeek4"

##data Directory
data_dir <- "Data"

##download URL
download_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

##file Name
file_name <- "Datasets.zip"

#create working directory and data subdirectory if not there
if (!file.exists(work_dir)) dir.create(work_dir)
if (!file.exists(file.path(work_dir,data_dir)))
  dir.create(file.path(work_dir,data_dir))

setwd(work_dir)  ##set working directory


datafile <- file.path(work_dir,data_dir,file_name)

if (!file.exists(datafile)) {
  download.file(download_URL,datafile)
  unzip(datafile,exdir=file.path(work_dir,data_dir))
}

udir <- "UCI HAR Dataset"  ##Unzipped files dir

##Step 1 - Merge training and test sets to create a combined set
dataset_train <- read.table(file.path(work_dir,data_dir,udir,"train/X_train.txt"))
dataset_test <- read.table(file.path(work_dir,data_dir,udir,"test/X_test.txt"))

label_train <- read.table(file.path(work_dir,data_dir,udir,"train/y_train.txt"))
label_test <- read.table(file.path(work_dir,data_dir,udir,"test/y_test.txt"))

subject_train <- read.table(file.path(work_dir,data_dir,udir,"train/subject_train.txt"))
subject_test <- read.table(file.path(work_dir,data_dir,udir,"test/subject_test.txt"))

dataset_combined <- rbind(dataset_train,dataset_test)
label_combined <- rbind(label_train,label_test)
subject_combined <- rbind(subject_train,subject_test)

##Step 2 - Extract only measurements on mean and std dev

##read in the features
features_list <- read.table(file.path(work_dir,data_dir,udir,"features.txt"))
##we take only the columns with mean and stdev
meanstd_cols <- grep(".*mean.*|.*std.*",features_list[,2])

##take only that subset of columns, and name them based on the description
dataset_meanstd <- dataset_combined[,meanstd_cols]
names(dataset_meanstd) <- features_list[meanstd_cols, 2] 

##Step 3 use the descriptive activity names 

activity <- read.table(file.path(work_dir,data_dir,udir,"activity_labels.txt"))
label_combined[,1] <- activity[label_combined[,1],2]


##Step 4 create combined tidy dataset
names(label_combined) <- "activity"
names(subject_combined) <- "subject"

dataset_tidy <- cbind(subject_combined,label_combined,dataset_meanstd)

write.table(dataset_tidy,"tidydata.txt")

##Step 5 create second tidy data set for average of each variable for each activity and subject

dataset_tidy$subject <-factor(dataset_tidy$subject) #make factor     

##"melt and recast data using reshape library"
library(reshape2)

dataset_melted <- melt(dataset_tidy, id=c("subject","activity"))
dataset_means <- dcast(dataset_melted, subject + activity ~ variable, mean)

write.table(dataset_means, "tidydatameans.txt")


