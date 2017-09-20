##set working directory to the UCI HAR Dataset folder

setwd("./UCI HAR Dataset")

##function readt() takes the tails of relevant file paths and, reads and names the data frames.

readt<-function(x){
  re<-paste("./", x, ".txt", sep="") 
  assign(gsub(".*\\/", "",x),read.table(re, stringsAsFactors=FALSE), envir = parent.frame())
}

readt("train/y_train");readt("train/x_train");readt("train/subject_train")
readt("test/y_test");readt("test/x_test"); readt("test/subject_test")

##functions Activity() and subject() that renames the variables of the subject and activity tables 
##from "V1" to activity and subject. 

subject<-function(x)
{rename(x, Subject=V1)}
subtr<-subject(subject_train)
subte<-subject(subject_test)
Activity<-function(x)
{rename(x, Activity=V1)}
acttr<-Activity(y_train)
actte<-Activity(y_test)

##1: binds the accelorometer/gyroscope data with the activity and subject data, for both test and 
##train datasets, then combines the two into a longer data fram

complete_test<-cbind(actte, subte, x_test)
complete_train<-cbind(acttr,subtr,x_train)
data<-rbind(complete_test,complete_train)


#2: renames the variables using the feature.txt data, and selects mean/std columns, and the activity and subject columns,  
##subsetting by grep output fr this regex. 
feat<-read.table("features.txt")
names(data)[3:563]<-as.character(feat[,2])
std_means<-grep("(std\\())+|(mean\\())+|Activity|Subject", names(data), value=TRUE)
std_means_data<-data[, std_means]

#3: creates yo function which transforms a value of x into the corresponding activity name from 
##activity.txt. yo is applied to the Activity column of the dataframe, and replaces the old column 

acti<-read.table("activity_labels.txt")
yo<-function(x){
  x<-acti$V2[which(acti$V1==x)]
  x
  }
act<-sapply(std_means_data$Activity, yo)
std_means_data<-mutate(std_means_data, Activity= as.factor((tolower(act))))

#4: Tidies up some of the special characters in the column names to underscores. 
tidy_names<-gsub("[-]|[()]", "_", colnames(std_means_data))
tidy_names<-gsub('_+','_', tidy_names)
tidy_names<-gsub('_$','', tidy_names)
colnames(std_means_data)<-tidy_names

#5: Groups the data by subject and activity, and uses summarize() to create a new dataset from the means of each variable.
grouped<-group_by(std_means_data, Subject, Activity)
new_table<- summarise_all(grouped, .funs="mean")



>
