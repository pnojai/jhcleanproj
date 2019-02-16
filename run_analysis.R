# Set up the project and get the data.
library(plyr) # Need this for join().

# Create target directory.
if (!dir.exists("./Data")) {
        dir.create("./Data")
}

# Get data.
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "./Data/HAR_Dataset.zip"
if (!file.exists(fileName)) {
        download.file(fileURL, destfile = fileName)
} else {
        print( paste("File exists, download skipped:", fileName))
}

dateDownloaded <- date()
dateDownloaded #  "Mon Feb 11 13:25:25 2019"

# Manually unzipped to ./Data

# Load reference data: Activity labels.
activity <- read.csv("Data/activity_labels.txt", header = FALSE, sep = " ")
names(activity) <- c("activityid", "activitydescription")

# Correct misspelling of activity, "LAYING". It's a factor, so you have to rename it to do that.
levels(activity$activitydescription)[levels(activity$activitydescription) == "LAYING"] <- "LYING"
levels(activity$activitydescription)
activity

# Load reference data: feature names
# These will become the variable names in the data frame for combined test and train data.
# Don't load as factors.
features <- read.csv("Data/features.txt", header = FALSE, sep = " ", stringsAsFactors = FALSE)
# Copy the description for transformation.
features <- cbind(features, features$V2, stringsAsFactors = FALSE)
names(features) <- c("featureID", "feature", "featureXForm")

# Transform the feature name.
# Change the hyphens to underscores.
# Remove the parentheses.
# Remove commas.
features$featureXForm <- gsub("[-,]", "_", features$featureXForm)
features$featureXForm <- gsub("\\()", "", features$featureXForm)
# Change ( and ) for angle variable names to underscore.
features$featureXForm <- gsub("[\\(]", "_", features$featureXForm)
# Drop trailing )
features$featureXForm <- gsub("[\\)$]", "", features$featureXForm)

# Are there any remaining "(" ?
grep("\\(", features$featureXForm)
# No.

# Inspect the transformations of the variable names.
features[1:250,]
features[features$featureID>250, ]

# featureXform will be the variable names for the test and train data frame.

#Load test data.
# Test 1. Feature data
xtest <- read.fwf("./Data/test/X_test.txt", widths = rep(16, 561), header = FALSE)

# Uncomment to view and verify loading
# str(xtest)
# head(xtest, 2)
# nrow(xtest)
# xtest[1:2, 1:2]
# names(xtest)

# Test 2.
# The columns in xtest are ready for naming using the transformed features.
# Both number 561.
ncol(xtest)
nrow(features)
names(xtest) <- features$featureXForm

# Test 3.
# Add a column to identify the source of the data, test or train.
xtest <- cbind(source = "TEST", xtest)

# Test 4.
# Add a column as a unique identifier for the test observations.
xtest <- cbind(sourceid = seq_along(xtest[ , 1]), xtest)

# Test 5.
# Add the subjects for the observations.
subjecttest <- read.csv("Data/test/subject_test.txt", header = FALSE)
xtest <- cbind(xtest, subject = subjecttest$V1)

head(xtest[ , c(1:3, 563:564)])
tail(xtest[ , c(1:3, 563:564)])

# Test 6.
# Add the activities for the observations
ytest <- read.csv("Data/test/y_test.txt", header = FALSE)
xtest <- cbind(xtest, activityid = ytest$V1)

head(xtest[ , c(1:3, 563:565)])
tail(xtest[ , c(1:3, 563:565)])

# Test 7.
# Join the activity descriptions.
intersect(names(xtest), names(activity))
xtest <- join(xtest, activity)

head(xtest[ , c(1:3, 563:566)])
tail(xtest[ , c(1:3, 563:566)])

# Load the train data and set it up like test.
# Train 1. Feature data
xtrain <- read.fwf("./Data/train/X_train.txt", widths = rep(16, 561), header = FALSE)

# Uncomment to view and verify loading
# str(xtrain)
# head(xtrain, 2)
# nrow(xtrain)
# xtrain[1:2, 1:2]
# names(xtrain)

# Train 2.
# The columns in xtrain are ready for naming using the transformed features.
# Both number 561.
ncol(xtrain)
nrow(features)
names(xtrain) <- features$featureXForm

# Train 3.
# Add a column to identify the source of the data, test or train.
xtrain <- cbind(source = "TRAIN", xtrain)

# Train 4.
# Add a column as a unique identifier for the test observations.
xtrain <- cbind(sourceid = seq_along(xtrain[ , 1]), xtrain)

# Train 5.
# Add the subjects for the observations.
subjecttrain <- read.csv("Data/train/subject_train.txt", header = FALSE)
xtrain <- cbind(xtrain, subject = subjecttrain$V1)

head(xtrain[ , c(1:3, 563:564)])
tail(xtrain[ , c(1:3, 563:564)])

# Train 6.
# Add the activities for the observations
ytrain <- read.csv("Data/train/y_train.txt", header = FALSE)
xtrain <- cbind(xtrain, activityid = ytrain$V1)

head(xtrain[ , c(1:3, 563:565)])
tail(xtrain[ , c(1:3, 563:565)])

# Train 7.
# Join the activity descriptions.
intersect(names(xtrain), names(activity))
xtrain <- join(xtrain, activity)

head(xtrain[ , c(1:3, 563:566)])
tail(xtrain[ , c(1:3, 563:566)])

# Union the test and train data.
# Include only those features which which mean and standard deviation.
includedfeatures <- grep("mean|std", names(xtest))
head(xtest[1:2, c(1:2, includedfeatures, 564, 566)])

xunion <- rbind(xtest[ , c(1:2, includedfeatures, 564, 566)],
                xtrain[ , c(1:2, includedfeatures, 564, 566)])

# Did I get all the rows? This difference should be 0.
(nrow(xtest) + nrow(xtrain)) - nrow(xunion)

# Rearrange the columns. Drop the key and source columns.
xunion <- cbind(xunion[ , 82:83], xunion[ , 3:81])

head(xunion)
tail(xunion)

# Average the features by subject and activity.
# Split by subject and activity.
xunion_split <- split(xunion, list(xunion$subject, xunion$activitydescription))

# Take a look at the counts of each split.
sapply(xunion_split, nrow)

# This is the first element in the list, one subject and activity.
xunion_split$`1.LYING`

# And its columns.
str(xunion_split$`1.LYING`)

# Take the means of all the numeric columns.
# Here's how you can do one split.
colMeans(xunion_split$`1.LYING`[, 3:81])

# Aggregate for each split.
activity_subject_means <- sapply(xunion_split, function(x) {colMeans(x[, 3:81])})

# Transpose the result.
activity_subject_means <- t(activity_subject_means)
activity_subject_means <- as.data.frame(activity_subject_means)
str(activity_subject_means)

head(activity_subject_means)

# One more step. The row names contain two variables. Is this considered tidy? In case it is not,
# divide them into two columns. 

splitRowNames <- strsplit(row.names(activity_subject_means), "\\.")
str(splitRowNames)

# The split row names are in a list. I want to pick off the first and second elements in turn,
# and create columns out of them. I'm hazy on why this use of sapply works, but it does.
activity_subject_means <- cbind(activitydescription = sapply(splitRowNames, "[[", 2),
                                subject = as.numeric(sapply(splitRowNames, "[[", 1)),
                                activity_subject_means)

# Get rid of the multi-variable row names.
rownames(activity_subject_means) <- NULL

# Voila.
# An independent tidy data set with the average of each variable for each activity and each subject.
head(activity_subject_means)

# Output the tidy file.
write.table(activity_subject_means, file = "./Data/activity_subject_means.txt", row.names = FALSE)
