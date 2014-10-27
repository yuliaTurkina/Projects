##create dir
if(!file.exists("data")){
      dir.create("data")
}

## download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data\\dataset.zip")
unzip("data\\dataset.zip", exdir="data")

##read train and test files
train <- read.table("data\\UCI HAR Dataset\\train\\X_train.txt") 
test <- read.table("data\\UCI HAR Dataset\\test\\X_test.txt") 

##union test and train data
full_data<-rbind(train,test)

##get list of variables
features <- read.table("data\\UCI HAR Dataset\\features.txt") 

##filter list of variables to find mean() and std() measures
features_new<-features[sort(c(grep("std()",features$V2, fixed=TRUE), grep("mean()",features$V2, fixed=TRUE))),]

##filter full_date: get variables from features_new
col_data<-full_data[,features_new$V1]

##create Id 
col_data$Id <- seq(1, nrow(col_data))

## read subject & activity for train & test
train_subject <- read.table("data\\UCI HAR Dataset\\train\\subject_train.txt") 
test_subject <- read.table("data\\UCI HAR Dataset\\test\\subject_test.txt") 
train_activity <- read.table("data\\UCI HAR Dataset\\train\\y_train.txt")
test_activity <- read.table("data\\UCI HAR Dataset\\test\\y_test.txt")
activity_name <- read.table("data\\UCI HAR Dataset\\activity_labels.txt")
colnames(activity_name)[1] <- "activity_id"
colnames(activity_name)[2] <- "activity_name"

## union subject data (train+test)
subject <- rbind(train_subject, test_subject)
colnames(subject)[1] <- "subject"
subject$Id <- seq(1, nrow(subject))

## union activity data (train+test)
activity <- rbind(train_activity, test_activity)
##activity<-merge(activity_temp, activity_name, by.x="V1", by.y="V1")
colnames(activity)[1] <- "activity_id"
activity$Id <- seq(1, nrow(activity))

## merge col_data, subject, activity on Id
merge_data <- merge(col_data,subject,  by.x="Id", by.y = "Id")
merge_data <- merge(merge_data,activity,  by.x="Id", by.y = "Id")

## get descriptive activity names
name_data<-merge(merge_data,activity_name,  by.x="activity_id", by.y="activity_id")

##delete Id and activity_id fields
temp_data <- name_data[,3:ncol(name_data)]

##rename columns
colnames(temp_data)<-features_new$V2
colnames(temp_data)[ncol(temp_data)]<-"activity"
colnames(temp_data)[ncol(temp_data)-1]<-"subject"

##create second dataset
final<-summarise_each(group_by(tidy_data,subject, activity),funs(mean))