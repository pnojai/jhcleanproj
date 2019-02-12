# Project Codebook
## Johns Hopkins Data Science - Getting and Cleaning Data

### Review of documentation and data
The data and its documentation were provided as a link in the project assignment to a zip archive. I downloaded and unzipped the archive into the project Data directory.

The file README.txt describes the experiment, Human Activity Recognition Using Smartphones, and it describes the contents of the dataset. The experimental data was divided by the researchers into a training set and a test set. The layout of the files is the same in each set, so I examined the test set which is smaller.

I examined the data files using a plaintext editor in order to determine the layout and delimiters. The file "X_test.txt" has no header, the numeric values are expressed in scientific notation, and the columns are fixed width. My text editor, Emacs, has counting functions that provided metrics about the layout.

**X_test.txt**

* One column contains 16 characters. Emacs counts the data point as 3 words.
* One row contains 1683 words which, divided by 3, suggests there are 561 columns in a row.
* One row contains 8976 characters which, divided by 16 also suggests there are 561 columns.
* A format of 561 columns, suggested by examination of the file, is consistent with the README.txt document and its reference to each record containing a 561-feature vector.
* The row count is 2947.

**features_info.txt**

The contents of this file identify the 561 variables recorded in the columns of the file X_test.txt.

**Data archive**

The language of the README.txt document required clarification. It documented the contents of each "record," which include accelerometer measurments from the smartphone, a 561-feature vector of variables in the time and frequency domains, etc. In strict data terms, the word "record" is misleading. Rather, there are multiple files whose records relate by sequence of observation. A better understanding is to interpret the word "record" as "recording," in other words "observation." The data files appear to relate by sequence of observation rather than by primary key / foreign key relationships. I validated this assumption by opening the various test files in Emacs by turn and counting the rows. Each of the following test data files contains 2947 records.

* X_test.txt. The 561-variable vector of time and frequency domain features.
* y_test.txt. Activity for each observation.
* subject_test.txt. Identifies the subject performing the observed activity.
* Files in the directory, InertialSignals. Each of 3 inertial signals is recorded in its own file, and one for each of the 3 axes of dimensional space, yielding a total of 9 files.

**activity_lables.txt**

Identifies the 6 activities performed by the test subjects, including walking and sitting. I noted a misleading choice of words for one of the activities, identified as "LAYING." The word "lay" is a transitive verb which means to put something down. The word "lie" is an intransitive verb referring to reclining. The website for the research linked to a video taken of one of the test observations. There appeared to be no activity in which the subject held an object and put it down. However, the subject did recline on a table in the course of the test and elsewhere in the documentation the researchers referred to the activity of "laying down." The activity label is an error of English usage on the part of the researchers and the intention was "LYING."

**body_acc_x_test.txt**

Validated the format using my plaintext editor, Emacs, as I did for the file X_test.txt.

* One column contains 16 characters. Emacs counts the data point as 3 words.
* One row contains 384 words which, divided by 3, suggests there are 128 columns in a row.
* One row contains 2048 characters which, divided by 16 also suggests there are 128 columns.
* A format of 128 columns, suggested by examination of the file, is consistent with the README.txt document and its reference to each record in the inertial signal files containing a 128-element vector.
* The row count is 2947.

### Scope of analysis
This data analysis project merges training and test datasets. It extracts means and standard deviations, which appear in the features recorded in files X_test.txt and X_train.txt. The researchers derived these features from inertial signals recorded in the files in the directories InertialSignals. The inertial signal data are, therefore, raw data which I disregarded for the scope of this analysis, relying instead on the feature data only.