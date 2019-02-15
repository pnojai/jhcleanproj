# Set up the project and get the data.

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
names(activity) <- c("activityID", "description")

# Correct misspelling of activity, "LAYING". It's a factor, so you have to rename it to do that.
levels(activity$description)[levels(activity$description) == "LAYING"] <- "LYING"
levels(activity$description)
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
# Feature data
xtest <- read.fwf("./Data/test/X_test.txt", widths = rep(16, 561), header = FALSE)

# Uncomment to view and verify loading
# str(xtest)
# head(xtest, 2)
# nrow(xtest)
# xtest[1:2, 1:2]
# names(xtest)

# The columns in xtest are ready for naming using the transformed features.
# Both number 561.
ncol(xtest)
nrow(features)

names(xtest) <- features$featureXForm

# Add a column to identify the source of the data, test or train.
xtest <- cbind(source = "TEST", xtest)
# Add a column as a unique identifier for the test observations.
xtest <- cbind(sourceid = seq_along(xtest[ , 1]), xtest)

# Add the subjects for the observations.
subjecttest <- read.csv("Data/test/subject_test.txt", header = FALSE)
xtest <- cbind(xtest, subject = subjecttest)

head(xtest[ , c(1:3, 563:564)])
tail(xtest[ , c(1:3, 563:564)])

# Load the train data and set it up like test.
xtrain <- read.fwf("./Data/train/X_train.txt", widths = rep(16, 561), header = FALSE)

# Uncomment to view and verify loading
# str(xtrain)
# head(xtrain, 2)
# nrow(xtrain)
# xtrain[1:2, 1:2]
# names(xtrain)

# The columns in xtrain are ready for naming using the transformed features.
# Both number 561.
ncol(xtrain)
nrow(features)

names(xtrain) <- features$featureXForm

# Add a column to identify the source of the data, test or train.
xtrain <- cbind(source = "TRAIN", xtrain)
# Add a column as a unique identifier for the train observations.
xtrain <- cbind(sourceid = seq_along(xtrain[ , 1]), xtrain)

head(xtrain[ , 1:3])
tail(xtrain[ , 1:3])

# I am to analyze only the means and standard deviations


#ytest <- read.fwf("./Data/test/y_test.txt", widths = 16, header = FALSE)

