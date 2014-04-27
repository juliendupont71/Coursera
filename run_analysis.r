# Read the X variables names
XColNames<-read.table("features.txt",header=FALSE,col.names=c("MeasID","MeasName"))

# Create a vector listing the X variables that we want to retain (only mean or std variables)
# It keeps only the measurements that have the patterns "-mean()" or "-std()" in their names
Select<-grep("*-mean\\()|*-std\\()",XColNames$MeasName)

# Read the X data for test and train
XTest<-read.table("./test/X_test.txt",header=FALSE,col.names=XColNames$MeasName)
XTrain<-read.table("./train/X_train.txt",header=FALSE,col.names=XColNames$MeasName)

# Subset the X tables
XTest<-XTest[,Select]
XTrain<-XTrain[,Select]

# Read the subject data for test and train
SubjTest<-read.table("./test/subject_test.txt",header=FALSE,col.names=c("SubjID"))
SubjTrain<-read.table("./train/subject_train.txt",header=FALSE,col.names=c("SubjID"))

# Read the y data for test and train
yTest<-read.table("./test/y_test.txt",header=FALSE,col.names=c("ActID"))
yTrain<-read.table("./train/y_train.txt",header=FALSE,col.names=c("ActID"))

# Append subject and activity IDs

XTest$ActID<-yTest$ActID
XTest$SubjID<-SubjTest$SubjID

XTrain$ActID<-yTrain$ActID
XTrain$SubjID<-SubjTrain$SubjID

# Merge both test and train datasets
Data<-rbind(XTest,XTrain)

# Add explicit activity names
Activities<-read.table("activity_labels.txt",header=FALSE,col.names=c("ActID","ActName"))
Activities$ActName<-as.factor(Activities$ActName)
Data<-merge(Data,Activities)
Data$ActID=NULL

# Final reshape using the reshape2 package as explained in Lecture 03, video 04
library(reshape2)
IdVar<-c("SubjID","ActName")
MeasVar<-setdiff(colnames(Data),IdVar)
Data2<-melt(Data,id=IdVar,measure.vars=MeasVar)
DataFinal<-dcast(Data2,ActName + SubjID ~ variable, mean)

# Save the dataset
write.table(DataFinal,"Tidy_Data_Set.txt")

