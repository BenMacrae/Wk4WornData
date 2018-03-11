#Load used packages
require(reshape2)
require(dplyr)

#Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","worndata.zip")
unzip("worndata.zip")

#Load all the relvant files into array variables:
subject_test<-as.data.frame(read.table("UCI HAR Dataset\\test\\subject_test.txt")) #A vector of test subjects
X_test<-as.data.frame(read.table("UCI HAR Dataset\\test\\X_test.txt")) #The data recorded
Y_test<-as.data.frame(read.table("UCI HAR Dataset\\test\\Y_test.txt"))  #The activity being performed
featurelist<-as.data.frame(read.table("UCI HAR Dataset\\features.txt")) #Column headings for the data in X_test

#Turn X_test into a dataframe and assign appropriate column headings from featurelist:
mytestdata <- cbind.data.frame(subject_test, Y_test, X_test)
names(mytestdata) <- c("subject", "activitycode", as.character(featurelist[,2]))

#Repeat exactly this for the training set:
subject_train<-as.data.frame(read.table("UCI HAR Dataset\\train\\subject_train.txt")) 
X_train<-as.data.frame(read.table("UCI HAR Dataset\\train\\X_train.txt")) 
Y_train<-as.data.frame(read.table("UCI HAR Dataset\\train\\Y_train.txt"))  
featurelist<-as.data.frame(read.table("UCI HAR Dataset\\features.txt"))
mytraindata <- cbind.data.frame(subject_train, Y_train, X_train)
names(mytraindata) <- c("subject", "activitycode", as.character(featurelist[,2]))

#Some exploration reveals that featurelist contains several repeated column names. 
#Using this code: 'repi<-hist(as.numeric(featurelist[,2]), breaks = c(0:477), plot = F); grep("[2-9]",repi$counts)' we identify the repeated factor levels in the vector. This returns: '[1]   8   9  10  11  12  13  14  15  16  17  18  19  20  21  59  60  61  62  63  64  65 [22]  66  67  68  69  70  71  72 162 163 164 165 166 167 168 169 170 171 172 173 174 175'.
#On closer inspection we realise that the corresponding data are not also repeated. Instead the creators of this dataset seem to have neglected to append the dimension that is being considered on the fBodyAccJerk-bandsEnergy() variables. This means that merging will not work as column headers are not unique. Instead we will just append the two datasets with rbind:

mergeddata <- rbind(mytestdata,mytraindata)

#Now we extract just the mean and standard deviation for each measurement. In the feature names the authors use mean() and std() as consistent lables, so we identify these and append them to the subject and activity variables:

meanandstonly <- cbind.data.frame(mergeddata[,1:2], mergeddata[,grepl("mean()|std()",names(mytestdata))])

#We now replace the activity names in the activity code variable with their associated string values in activity_labels.txt, and append this vector to the front of the dataframe.

activitylabels <- as.data.frame(read.table("UCI HAR Dataset\\activity_labels.txt"))
activities <- as.data.frame(meanandstonly[,2])
names(activities) <- "activityname"
for(i in 1:6){activities <- replace(activities, activities == i, as.character(activitylabels[i,2]))}
meanandstonly <- cbind(activities,meanandstonly)

#We now want to find the mean value of each of these for each value and each subject. We will use the measurements as rows and the subjects and activities as columns, as it is natural to subset the data by the people or activities we are interested in. We will use the reshape library for this task.

melted <- melt(meanandstonly, id=c("subject","activityname","activitycode"))
subjectmeans <- dcast(melted, variable~subject, mean)
activitymeans <- dcast(melted, variable~activityname, mean)
allmeans <- merge(activitymeans,subjectmeans)

#We now save this dataset.
write.table(allmeans,"MeansOfMeansandSDsForWornData.csv", row.names = F)