# DOWNLOAD FILE
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDirName <- "."
workDirName <- "UCI HAR Dataset"
fileName <- "UCI HAR Dataset.zip"
outputFileName <- "results.txt"

# START PROG
fileDestination <- paste(dataDirName, fileName, sep="/")

# skip directory and file creation if it already exists
if (!file.exists(fileDestination)) {
  
  # create data directory if it doesn't exist
  if (!file.exists(dataDirName)) {
    dir.create(dataDirName)
  }
  
  # download data file
  download.file(fileUrl, destfile=fileDestination, method="curl")
  
  # extract file
  unzip(fileDestination)
}


# 1. Merges the training and the test sets to create one data set.
fileTypes <- c("subject","X","y")

for (i in fileTypes) {
  # Create file pattern based on the fileTypes list
  inputFilePattern <- paste0(i,"*.txt")

  # Create dynamic name of data variable, so we don't have to repeatedly call the same commands
  outputVarName <- paste0("data.", i)

  # Get a list of all filenames that fulfill the pattern
  filenameList <- list.files(paste(dataDirName, workDirName, sep="/"), pattern=glob2rx(inputFilePattern), recursive=TRUE)
  
  # Loop through the fileList (lapply) and move like filetypes to the same variable
  assign(outputVarName, do.call("rbind", lapply(filenameList, FUN=function(filename){read.table(paste(dataDirName, workDirName, filename, sep="/"))})))
}

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dataLabels.X <- read.table(paste(dataDirName, workDirName, "features.txt", sep="/"))
dataLabels.X.meanStd <- dataLabels.X[grep("-mean\\(|-std\\(", dataLabels.X[[2]]), ]

data.X.meanStd <- data.X[, dataLabels.X.meanStd[[1]]]

# 3. Uses descriptive activity names to name the activities in the data set
dataLabels.y <- read.table(paste(dataDirName, workDirName, "activity_labels.txt", sep="/"))
data.y$description <- dataLabels.y[[2]][match(data.y[[1]], dataLabels.y[[1]])]

# 4. Appropriately labels the data set with descriptive variable names. 
dataLabels.X.clean <- dataLabels.X.meanStd[[2]]

dataLabels.X.clean <- gsub("mean\\(\\)", "Mean", dataLabels.X.clean)
dataLabels.X.clean <- gsub("std\\(\\)", "SD", dataLabels.X.clean)
dataLabels.X.clean <- gsub("Gyro", "Gyroscope", dataLabels.X.clean)
dataLabels.X.clean <- gsub("Mag", "Magnitude", dataLabels.X.clean)
dataLabels.X.clean <- gsub("Acc", "Accelerometer", dataLabels.X.clean)
dataLabels.X.clean <- gsub("BodyBody", "Body", dataLabels.X.clean)
dataLabels.X.clean <- gsub("^t", "3D-", dataLabels.X.clean, perl=TRUE)
dataLabels.X.clean <- gsub("^f", "FFT-", dataLabels.X.clean, perl=TRUE)

names(data.X.meanStd) <- dataLabels.X.clean

# combine the datasets
data.combined <- cbind(data.subject, data.y[[2]], data.X.meanStd)

# give appropriate names
names(data.combined)[1] <- "Subject"
names(data.combined)[2] <- "ActivityType"

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data.result <- aggregate(data.combined[3:length(data.combined)], data.combined[1:2], FUN="mean")

# write out correct dataset
outputFilePath <- paste(dataDirName, outputFileName, sep="/")
write.table(data.result, file=outputFilePath, row.name=FALSE)
