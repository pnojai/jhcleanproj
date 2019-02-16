# Project Codebook
## Johns Hopkins Data Science - Getting and Cleaning Data

### Review of documentation and data
The data and its documentation were provided as a link in the project assignment to a zip archive. I downloaded and unzipped the archive into the project Data directory.

The dataset includes the file, README.txt. This is a distinct file from the document, README.md, located in the working directory of the project repository. The dataset file, README.txt, describes the experiment, Human Activity Recognition Using Smartphones, and it describes the contents of the dataset. The experimental data was divided by the researchers into a training set and a test set. The layout of the files is the same in each set, so I examined the test set which is smaller.

The language of the README.txt document required clarification. It documented the contents of each "record," which include accelerometer measurements from the smartphone, a 561-feature vector of variables in the time and frequency domains, etc. In strict data terms, the word "record" is misleading. Rather, there are multiple files whose records relate by sequence of observation. A better understanding is to interpret the word "record" as "recording," that is to say that for each recording of a test subject's experimental actions, the measurements are written to several related files.

The data files appear to relate by sequence of observation rather than by primary key / foreign key relationships. I validated this assumption by opening the various test files in Emacs by turn and counting the rows. Each of the following test data files contains 2947 records.

* X_test.txt. The 561-variable vector of time and frequency domain features.
* y_test.txt. Activity for each observation.
* subject_test.txt. Identifies the subject performing the observed activity.
* Files in the directory, InertialSignals. Each of 3 inertial signals is recorded in its own file, and one for each of the 3 axes of dimensional space, yielding a total of 9 files.

I examined the data files using a plaintext editor in order to determine the layout and delimiters. The examination determined that the file "X_test.txt" has no header or delimiter, the numeric values are expressed in scientific notation, and the columns are fixed width. My text editor, Emacs, has counting functions that provided metrics about the layout, as follows.

**X_test.txt**

* One column contains 16 characters. Emacs counts the data point as 3 words.
* One row contains 1683 words which, divided by 3 words per data point, suggests there are 561 columns in a row.
* One row contains 8976 characters which, divided by an observed 16 characters per column, also suggests there are 561 columns.
* A format of 561 columns, suggested by examination of the file, is consistent with the README.txt document and its reference to each record containing a 561-feature vector.
* The row count is 2947.

**features.txt**

The contents of this file identify the 561 variables recorded in the columns of the file X_test.txt.

**y_test.txt**

The activity label code associated with each observation of features in X_test.txt. The decoded descriptions of label codes are in the file activity_labels.txt.

**activity_lables.txt**

Identifies the 6 activities performed by the test subjects, including walking and sitting. I noted a misleading choice of words for one of the activities, identified as "LAYING." The word "lay" is a transitive verb which means to put something down. The word "lie" is an intransitive verb referring to reclining. The website for the research linked to a video taken of one of the test observations. There appeared to be no activity in which the subject held an object and put it down. However, the subject did recline on a table in the course of the test and elsewhere in the documentation the researchers referred to the activity of "laying down." The activity label is an error of English usage on the part of the researchers and the intention appears to have been "LYING," which I corrected in the analysis output.

**body_acc_x_test.txt, etc.**

I validated the formats of the Inertial Signals files using my plaintext editor, Emacs, as I did for the file X_test.txt.

* One column contains 16 characters. Emacs counts the data point as 3 words.
* One row contains 384 words which, divided by 3, suggests there are 128 columns in a row.
* One row contains 2048 characters which, divided by 16 also suggests there are 128 columns.
* A format of 128 columns, suggested by examination of the file, is consistent with the README.txt document and its reference to each record in the inertial signal files containing a 128-element vector.
* The row count is 2947.

### Scope of analysis
This data analysis project merges training and test datasets. It extracts means and standard deviations, which appear in the features recorded in files X_test.txt and X_train.txt. The researchers derived these features from inertial signals recorded in the files in the directories, Inertial Signals." The inertial signal data are, therefore, raw data which I disregarded for the scope of this analysis, relying instead on the feature data only.

### Output and variable names
The deliverable for the project is the file, Data/activity_subject_means.txt. It contains the mean for every in-scope variable grouped by activity and subject.

The activity description comes from the dataset file, activity_labels.txt. Subject is only identified within the dataset by an integer. There were 30 subjects.

The data measurements were assembled by the researchers into features, which were the subject of this analysis. The names of those features come from the file, features.txt.

**Transformations**

I manipulated the feature names in the file, features.txt, to form suitable variable names for the output file. The transformations included:

* Hyphens became underscores.
* Removed parentheses.
* Removed commas.
* Removed periods.

The variables in the output file, activity_subject_means.txt, are as follows.

Variable               | Definition
-----------------------| -------------------------------------------
activitydescription| Description of experimental activity
subject | Experimental subject, identified by integer code
tBodyAcc_mean_X | Mean of time domain body acceleration mean in the x axis
tBodyAcc_mean_Y | Mean of time domain body acceleration mean in the y axis
tBodyAcc_mean_Z | Mean of time domain body acceleration mean in the z axis
tBodyAcc_std_X | Mean of time domain body acceleration standard deviation in the x axis
tBodyAcc_std_Y | Mean of time domain body acceleration standard deviation in the y axis
tBodyAcc_std_Z | Mean of time domain body acceleration standard deviation in the z axis
tGravityAcc_mean_X | Mean of time domain gravity acceleration mean in the x axis
tGravityAcc_mean_Y | Mean of time domain gravity acceleration mean in the y axis
tGravityAcc_mean_Z | Mean of time domain gravity acceleration mean in the z axis
tGravityAcc_std_X | Mean of time domain gravity acceleration standard deviation in the x axis
tGravityAcc_std_Y | Mean of time domain gravity acceleration standard deviation in the y axis
tGravityAcc_std_Z | Mean of time domain gravity acceleration standard deviation in the z axis
tBodyAccJerk_mean_X | Mean of time domain body acceleration jerk mean in the x axis
tBodyAccJerk_mean_Y | Mean of time domain body acceleration jerk mean in the y axis
tBodyAccJerk_mean_Z | Mean of time domain body acceleration jerk mean in the z axis
tBodyAccJerk_std_X | Mean of time domain body acceleration jerk standard deviation in the x axis
tBodyAccJerk_std_Y | Mean of time domain body acceleration jerk standard deviation in the y axis
tBodyAccJerk_std_Z | Mean of time domain body acceleration jerk standard deviation in the z axis
tBodyGyro_mean_X | Mean of time domain body gyroscope mean in the x axis
tBodyGyro_mean_Y | Mean of time domain body gyroscope mean in the y axis
tBodyGyro_mean_Z | Mean of time domain body gyroscope mean in the z axis
tBodyGyro_std_X | Mean of time domain body gyroscope standard deviation in the x axis
tBodyGyro_std_Y | Mean of time domain body gyroscope standard deviation in the y axis
tBodyGyro_std_Z | Mean of time domain body gyroscope standard deviation in the z axis
tBodyGyroJerk_mean_X | Mean of time domain body gyroscope jerk mean in the x axis
tBodyGyroJerk_mean_Y | Mean of time domain body gyroscope jerk mean in the y axis
tBodyGyroJerk_mean_Z | Mean of time domain body gyroscope jerk mean in the z axis
tBodyGyroJerk_std_X | Mean of time domain body gyroscope jerk standard deviation in the x axis
tBodyGyroJerk_std_Y | Mean of time domain body gyroscope jerk standard deviation in the y axis
tBodyGyroJerk_std_Z | Mean of time domain body gyroscope jerk standard deviation in the z axis
tBodyAccMag_mean | Mean of time domain body acceleration magnitude mean
tBodyAccMag_std | Mean of time domain body acceleration magnitude standard deviation
tGravityAccMag_mean | Mean of time domain gravity acceleration magnitude mean
tGravityAccMag_std | Mean of time domain gravity acceleration magnitude standard deviation
tBodyAccJerkMag_mean | Mean of time domain body acceleration jerk magnitude mean
tBodyAccJerkMag_std | Mean of time domain body acceleration jerk magnitude standard deviation
tBodyGyroMag_mean | Mean of time domain body gyroscope magnitude mean
tBodyGyroMag_std | Mean of time domain body gyroscope magnitude standard deviation
tBodyGyroJerkMag_mean | Mean of time domain body gyroscope jerk magnitude mean
tBodyGyroJerkMag_std | Mean of time domain body gyroscope jerk magnitude standard deviation
fBodyAcc_mean_X | Mean of frequency domain body acceleration mean in the x axis
fBodyAcc_mean_Y | Mean of frequency domain body acceleration mean in the y axis
fBodyAcc_mean_Z | Mean of frequency domain body acceleration mean in the z axis
fBodyAcc_std_X | Mean of frequency domain body acceleration standard deviation in the x axis
fBodyAcc_std_Y | Mean of frequency domain body acceleration standard deviation in the y axis
fBodyAcc_std_Z | Mean of frequency domain body acceleration standard deviation in the z axis
fBodyAcc_meanFreq_X | Mean of frequency domain body acceleration mean frequency in the x axis
fBodyAcc_meanFreq_Y | Mean of frequency domain body acceleration mean frequency in the y axis
fBodyAcc_meanFreq_Z | Mean of frequency domain body acceleration mean frequency in the z axis
fBodyAccJerk_mean_X | Mean of frequency domain body acceleration jerk mean in the x axis
fBodyAccJerk_mean_Y | Mean of frequency domain body acceleration jerk mean in the y axis
fBodyAccJerk_mean_Z | Mean of frequency domain body acceleration jerk mean in the z axis
fBodyAccJerk_std_X | Mean of frequency domain body acceleration jerk standard deviation in the x axis
fBodyAccJerk_std_Y | Mean of frequency domain body acceleration jerk standard deviation in the y axis
fBodyAccJerk_std_Z | Mean of frequency domain body acceleration jerk standard deviation in the z axis
fBodyAccJerk_meanFreq_X | Mean of frequency domain body acceleration jerk mean frequency in the x axis
fBodyAccJerk_meanFreq_Y | Mean of frequency domain body acceleration jerk mean frequency in the y axis
fBodyAccJerk_meanFreq_Z | Mean of frequency domain body acceleration jerk mean frequency in the z axis
fBodyGyro_mean_X | Mean of frequency domain body gyroscope mean in the x axis
fBodyGyro_mean_Y | Mean of frequency domain body gyroscope mean in the y axis
fBodyGyro_mean_Z | Mean of frequency domain body gyroscope mean in the z axis
fBodyGyro_std_X | Mean of frequency domain body gyroscope standard deviation in the x axis
fBodyGyro_std_Y | Mean of frequency domain body gyroscope standard deviation in the y axis
fBodyGyro_std_Z | Mean of frequency domain body gyroscope standard deviation in the z axis
fBodyGyro_meanFreq_X | Mean of frequency domain body gyroscope mean frequency in the x axis
fBodyGyro_meanFreq_Y | Mean of frequency domain body gyroscope mean frequency in the y axis
fBodyGyro_meanFreq_Z | Mean of frequency domain body gyroscope mean frequency in the z axis
fBodyAccMag_mean | Mean of frequency domain body acceleration magnitude mean
fBodyAccMag_std | Mean of frequency domain body acceleration magnitude standard deviation
fBodyAccMag_meanFreq | Mean of frequency domain body acceleration magnitude mean frequency
fBodyBodyAccJerkMag_mean | Mean of frequency domain body acceleration jerk magnitude mean
fBodyBodyAccJerkMag_std | Mean of frequency domain body acceleration jerk magnitude standard deviation
fBodyBodyAccJerkMag_meanFreq | Mean of frequency domain body acceleration jerk magnitude mean frequency
fBodyBodyGyroMag_mean | Mean of frequency domain body gyroscope magnitude mean
fBodyBodyGyroMag_std | Mean of frequency domain body gyroscope magnitude standard deviation
fBodyBodyGyroMag_meanFreq | Mean of frequency domain body gyroscope magnitude mean frequency
fBodyBodyGyroJerkMag_mean | Mean of frequency domain body gyroscope magnitude mean
fBodyBodyGyroJerkMag_std | Mean of frequency domain body gyroscope magnitude standard deviation
fBodyBodyGyroJerkMag_meanFreq | Mean of frequency domain body gyroscope magnitude mean frequency
 