# This ReadMe contains a description of the script and the dataset in MeansOfMeansandSDsForWornData.csv
We aquired the data set contained within https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This contains the results of monitoring the linear and angular acceleration experienced by a smartphone whalst each of 30 test subjects conducted one of 6 activities (laying, sitting, standing, walking, walking up stairs, walking down stairs). The test group have been separated into a training and test group for use by machine learning software, and physical constants such as surge have then been generated for each characteristic of motion, for each person and activity. These constants stored in the files named X_test.txt and X_train.txt are what we will be refering to as the datasets from now one.  See the accompanying documentation for more details.

The script run_analysis.R does the following:
Downloads the file linked above.
Unzips it to the working directory.
For the 'test' dataset it loads the list of test subjects, the data, the list of activities and the list of column headings for the data from their files into seperate variables.
We then combine the first three into one dataset using cbind() and apply the correct column headings.

This process is repeated exactly for the training dataset.

We then stack the two sets verticaly using rbind(), and select from this set only those variables containing the mean and standard devation of their measurement.

Finally we use the reshape package to find the mean of each of our variables for each of the activities and test subjects.




