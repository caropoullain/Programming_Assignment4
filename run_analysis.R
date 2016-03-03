## Assignment 4

setwd("/Users/Caro/Documents/Coursera/Getting_and_cleaning_data/Week4/HAR")
  
#Loading files into R
X_test<-read.table("./HAR/test/X_test.txt")
y_test<-read.table("./HAR/test/y_test.txt")
subject_test<-read.table("./HAR/test/subject_test.txt")
X_train<-read.table("./HAR/train/X_train.txt")
y_train<-read.table("./HAR/train/y_train.txt")
subject_train<-read.table("./HAR/train/subject_train.txt")
features<-read.table("./HAR/features.txt")
activity<-read.table("./HAR/activity_labels.txt")
  
dim(X_test)
dim(y_test)
dim(subject_test)
dim(X_train)
dim(y_train)
dim(subject_train)
dim(features)
dim(activity)
  
#Merge datasets
Raw <- rbind(X_test,X_train)
ActivityID<-rbind(y_test,y_train)
subjectID<-rbind(subject_test,subject_train)
Features_inc<-grep("mean|std",features[,2])
dim(Raw)
dim(ActivityID)
dim(subjectID)
  
#Giving the column subjectID a header name
colnames(subjectID)<-"SubID"
  
#Merging Activity labels with Y
library(plyr)
Activity<-join(ActivityID,activity)
Activity2<-Activity[,2]
Activity2<-data.frame(Activity2)
colnames(Activity2)<-"Activity_Label"
  
#Labelling the "Raw" data
Raw<-Raw[,Features_inc]
names(Raw)<-gsub("\(|\)","",features$V2[Features_inc])
  
#Complete data set made
Alldata<-cbind(subjectID,Raw,Activity2)
write.table(Alldata,"merged_Alldata.txt")
  
#Calculating mean and SD
library(data.table)
TidyData<-data.table(Alldata)
MeanSD<-TidyData[,lapply(.SD,mean), by=c("SubID","Activity_Label")]
write.table(MeanSD,"MeanSD_Tidy_Data.txt", row.name=FALSE)}
