X_test<-read.table("./UCI HAR Dataset/test/X_test.txt",header=F,stringsAsFactors=F)
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt",header=F,stringsAsFactors=F)
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt",header=F,stringsAsFactors=F)
Y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt",header=F,stringsAsFactors=F)
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=F,stringsAsFactors=F)

subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=F,stringsAsFactors=F)

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=F,stringsAsFactors=F)
features<-read.table("./UCI HAR Dataset/features.txt",header=F,stringsAsFactors=F)


colnames(Y_test)<-c("activity")
colnames(subject_test)<-c("subject")
mergetest<-cbind(subject_test,Y_test,X_test)


colnames(subject_train)<-c("subject")
colnames(Y_train)<-c("activity")
mergetrain<-cbind(subject_train,Y_train,X_train)

mergeboth<-rbind(mergetrain,mergetest)

names<-t(features)[2,]

colnames(mergeboth)[3:563]<-names



mergeboth<-mergeboth[,grep("subject|activity|mean\\(\\)|std\\(\\)",colnames(mergeboth))]
library(dplyr)
merg_tbl<-tbl_df(mergeboth)

for (i in c(1:6)) { merg_tbl$activity[merg_tbl$activity==i] <- activity_labels$V2[i]}


colnames(merg_tbl)<-gsub("\\(\\)","",colnames(merg_tbl))
colnames(merg_tbl)<-gsub("\\-","\\.",colnames(merg_tbl))


merg_tbl<-merg_tbl %>% group_by(subject,activity) 

tidyData<-summarise_each(merg_tbl, funs(mean))
