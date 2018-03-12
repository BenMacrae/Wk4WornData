# Code Book
This is mostly deduced from the features.txt and readme.txt files associated with the data, refer to them for more details.

The dataset sourced from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones contains the results of monitoring the linear and angular acceleration experienced by a smartphone whalst each of 30 test subjects conducted one of 6 activities (laying, sitting, standing, walking, walking up stairs, walking down stairs). A range of physical variables and corresponding summary statistics were then generated. The physical variables are:

* tBodyAcc-XYZ 
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The meanings behind these names can be deduced from:
t = timespace, f = frequencyspace (i.e. after a Fast Fourier Transform).
Body = we have removed the effect of gravity. Gravity =  acceleration due to gravity.
Acc = measured by the accelerometer. Gyro = measured by the gyroscope.
Mag = magnitude of the variable. -X, -Y or -Z indicates the component in just that dimension.
Jerk = Derived measurement of jerk. If this is not present then the measurement is the acceleration.

All features have been normalised so that the max value is in the bound [1,-1]

We have then taken the mean and standard deviation of these, demarked by mean() and std() in the variable names.

The dataset MeansOfMeansandSDsForWornData.csv can be loaded using read.table("MeansofMeansandSDsForWornData.txt", header = T). It contains the mean of each of these variables' time series for each of the people and each of the activities. The column heading are the activities given by name, and the test subjects enumerated X1 to X30. The variables described above then give the row headings.





