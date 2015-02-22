#Get the data from given files

FeaturesTrain<-read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
FeaturesTest<-read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
ActivityTest<-read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
ActivityTrain<-read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
SubjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
SubjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)

# rbind() data fron X_train and X_test
dataFeatures<-rbind(FeaturesTrain,FeaturesTest)

#rbind() data from y_train and y_test
dataActivity<-rbind(ActivityTrain,ActivityTest)

# get the names of activites
Activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
# set the variable names from activity_labels.txt
dataActivity[, 1]<-Activity[dataActivity[, 1], 2]

#rbind() subject_test and subject_train
dataSubject<-rbind(SubjectTrain,SubjectTest)
#set variable names
Features<-read.table("./UCI HAR Dataset/features.txt")
names(dataFeatures)<-Features$V2
names(dataActivity)<-c("Activity")
names(dataSubject)<-c("Subject")

#get full data. use cbind() for this
DATA<-cbind(dataFeatures,dataSubject,dataActivity)
#Extracts only the measurements on the mean and standard deviation
SubsetNames<-as.character(Features$V2[grep("mean\\(\\)|std\\(\\)",Features$V2)])
Sub_DATA<-subset(DATA,select = SubsetNames)
#create independent tidy data set with the average of each variable for each activity and each subject
averg<-aggregate(.~Activity+Subject,DATA,mean)
#write this data to the file
write.table(averg, "averages_data.txt", row.name=FALSE)
