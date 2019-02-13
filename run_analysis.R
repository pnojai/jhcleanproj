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

# Load reference data: 
#Load test data.
# Feature data
xtest <- read.fwf("./Data/test/X_test.txt", widths = rep(16, 561), header = FALSE)

# Uncomment to view and verify loading
# str(xtest)
# head(xtest, 2)
# nrow(xtest)
# xtest[1:2, 1:2]
# names(xtest)

#ytest <- read.fwf("./Data/test/y_test.txt", widths = 16, header = FALSE)

