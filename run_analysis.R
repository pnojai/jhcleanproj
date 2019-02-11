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


