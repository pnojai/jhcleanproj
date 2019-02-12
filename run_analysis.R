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

# Visual examination of data

# Explore the test data and train data.
xtest <- read.fwf("./Data/test/X_test.txt", widths = rep(16, 1683), header = FALSE)
ytest <- read.fwf("./Data/test/y_test.txt", widths = 16, header = FALSE)

str(xtest)

head(xtest, 2)
head(ytest, 2)


nrow(xtest)

xtest[1]
