#reading the training dataset and the test dataset
training.data=read.table(file="X_train.txt",sep="",header=FALSE)
test.data=read.table(file="X_test.txt",sep="",header=FALSE)

#running dimension checks -on the training data and test data
dim(training.data)
dim(test.data)

#reading the subject number datasets
training.subjects=read.table(file="subject_train.txt",sep="",header=FALSE)
test.subjects=read.table(file="subject_test.txt",sep="",header=FALSE)

#giving column name for the subject number datasets
colnames(training.subjects)="subject"
colnames(test.subjects)="subject"

#running dimension checks -on the subject datasets
dim(training.subjects)
dim(test.subjects)
head(training.subjects)
head(test.subjects)

#reading the activity code datasets
training.data.activity=read.table(file="y_train.txt",sep="",header=FALSE)
test.data.activity=read.table(file="y_test.txt",sep="",header=FALSE)

#giving column names to the activity code datasets
colnames(training.data.activity)="Activity"
colnames(test.data.activity)="Activity"

#running checks -on the activity code datasets
dim(training.data.activity)
dim(test.data.activity)
head(training.data.activity)
head(test.data.activity)

#converting "activity" to factor variables
training.data.activity$Activity=as.factor(training.data.activity$Activity)
test.data.activity$Activity=as.factor(test.data.activity$Activity)

#recoding the factor levels of "activity" (1,2,3,4,5) using plyr package
library(plyr)
training.data.activity$Activity=revalue(training.data.activity$Activity,c("1"="Walking","2"="Walking Upstairs","3"="Walking Downstairs",
                                                                          "4"="Sitting","5"="Standing","6"="Laying"))


test.data.activity$Activity=revalue(test.data.activity$Activity,c("1"="Walking","2"="Walking Upstairs","3"="Walking Downstairs",
                                                                  "4"="Sitting","5"="Standing","6"="Laying"))


# QUESTION 1 - merging the subject number datasets  & activity datasets with the respective training/test dataset
training.data=cbind(training.subjects,training.data.activity,training.data)
test.data=cbind(test.subjects,test.data.activity,test.data)

#merging data sets created in above step to ONE dataset, it will be called combined.data
combined.data=rbind(training.data,test.data)
dim(combined.data)

#renaming the column names of the combined.data : 1st column is subject, 2nd column is Activity
#rest of the 561 columns are the measurements.
#features.txt file has the names of measurements, will pick up the measurement names from the file
features.names.data=read.table(file="features.txt",sep="",header=FALSE,col.names=c("SNo","Feature_Name"))
#transposing the feature.names dataframe so that the (transposed) rows contents can be uses as names
measurement.names=as.character(t(features.names.data[,2]))

#naming the measurement related columns of the combined dataset
colnames(combined.data)=c("Subject","Activity",measurement.names)

#extracting only those columns which pertain to mean of measurements, used grep to collect such columns
mean.columns.only=combined.data[, grep("mean()",names(combined.data))]
mean.names=names(mean.columns.only)

#extracting only those columns which pertain to standard deviation of measurements, used grep to collect such columns
std.columns.only=combined.data[,grep("std()",names(combined.data))]
std.names=names(std.columns.only)

#QUESTION 2- cbinding the datasets to obtain dataset of only mean & std measurements
combined.data.final=cbind(combined.data[,1],combined.data[,2],mean.columns.only,std.columns.only)

#QUESTION 3 & 4 -providing  names to all the columns of the combined dataset
#the dataset has 81  columns, the 1st and 2nd column already have names - Subject and Activity
#columns 3 to 81 are the related to measurements
names(combined.data.final)=c("Subject","Activity",mean.names[1:46],std.names[1:33])

#writing out the combined.data into a file
write.table(combined.data.final,"combined.txt",sep="",col.names=TRUE,row.names=FALSE)

#QUESTION 5 -creating independent, tidy dataset : Average values for each variable  for each activity*subject combination
#achieve this using the aggregate command
#the aggregate command obtains for each of the 79 measurements, their mean grouped by Subject and Activity
tidy.dataset=aggregate(combined.data.final[,3:81],by=list(combined.data.final$Subject,combined.data.final$Activity),FUN=mean,na.rm=TRUE)

#providing column names for the tidy.dataset
names(tidy.dataset)=c("Subject","Activity",mean.names,std.names)

# writing the tidy dataset to a text file
write.table(tidy.dataset,"final_tidydataset.txt",col.names=TRUE,row.names=FALSE,sep="")
