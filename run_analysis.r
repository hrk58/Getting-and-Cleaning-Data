library(plyr)

#' ---
#' title: "Run Analysis"
#' author: "Rebecca Kimmel"
#' date:   "24 July 2015"
#' ---     
#' 
#' # Purpose
#' 
#' This function takes 8 files located in your working directory.  The files
#' are located: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#' The file needs to be downloaded and the files unzipped in your working directory.
#' 
#' The names of the files that are required by this function are:
#' 1. y_test.txt          Activities performed by the subjects
#' 2. subject_test.txt    Subjects who performed the activities
#' 3. X_test.txt          Data acquired from the Samsung phone for each subject/activity
#' 4. y_train.txt
#' 5. X_train.txt
#' 6. subject_train.txt
run_analysis <- function() {

     
     #----------- Read the data files ----------------------------------
     
     print("Reading Test Data ....")
     
     dataActivityTest  <- read.table ("y_test.txt" ,header = FALSE)
     dataSubjectTest   <- read.table ("subject_test.txt", header = FALSE)
     dataFeaturesTest  <- read.table ( "X_test.txt" ,header = FALSE)
     
     print ("Reading Training Data ....")
     
     dataActivityTrain  <- read.table ("y_Train.txt" ,header = FALSE)
     dataSubjectTrain   <- read.table ("subject_Train.txt", header = FALSE)
     dataFeaturesTrain  <- read.table ( "X_Train.txt" ,header = FALSE)
     
     #------------ Merge the Test and Training Data together -------------
     
     print ("Merging Training and Test Data together ....")
     
     dataSubject  <- rbind(dataSubjectTrain, dataSubjectTest)
     dataActivity <- rbind(dataActivityTrain, dataActivityTest)
     dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)
     
     #------------ Add more readable labels ------------------------------
     
     print ("Updating labels for Subject and Subject Activities ....")
     
     names(dataSubject)  <- c("Subject")
     names(dataActivity) <- c("Activity ID")
     
     print ("Reading Activity and Feature definition files ....")
     
     activityLabels        <- read.table ("activity_labels.txt",header = FALSE)
     names(activityLabels) <- c("Activity ID", "Activity")
     
     dataFeaturesNames     <- read.table("features.txt",head=FALSE)
     names(dataFeatures)   <- dataFeaturesNames$V2
     
     print ("Combining Subject, Activity, with Feature Data.")
     
     dataCombine <- cbind(dataSubject, dataActivity)
     Data        <- cbind(dataFeatures, dataCombine)
     
     print("Creating Subset of data containing only mean and std feature data ....")
     
     subFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", 
                                                   dataFeaturesNames$V2)]
     
     
     selectedNames <- c(as.character(subFeaturesNames), "Subject", "Activity ID")
     Data <- subset(Data, select=selectedNames)
     Data <- mutate(Data, Activity = activityLabels[Data$`Activity ID` ,2])
     Data$`Activity ID` <- NULL  
     
     #---------- Tidy the data up by aggregating on mean then ordering it ---------
     
     print ("Tidying the Data that contains the average (mean) of each variable.")
     print ("Ordered by Subject and Activity ....")
     
     tidyData <- aggregate(. ~Subject + Activity, Data, mean)
     tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity), ]
     
     names(tidyData) <- gsub("^t",       "time",          names(tidyData))
     names(tidyData) <- gsub("^f",       "frequency",     names(tidyData))
     names(tidyData) <- gsub("Acc",      "Accelerometer", names(tidyData))
     names(tidyData) <- gsub("Gyro",     "Gyroscope",     names(tidyData))
     names(tidyData) <- gsub("Mag",      "Magnitude",     names(tidyData))
     names(tidyData) <- gsub("BodyBody", "Body",          names(tidyData))
     names(tidyData) <- gsub("\\(|\\)",   "",             names(tidyData))
     
     #---------- View the data and write it out to a file -------------------------
     
     View(tidyData, "Results of Samsung Data")
     
     return(tidyData)

     write.table(tidyData, file = "tidydata.txt",row.name=FALSE)
     print("Results have been saved and are located in ./tidydata.txt") 
     
     return(tidyData)
     
}
     





