---
title: "README"
author: "Rebecca Kimmel"
date: "July 24, 2015"
output: word_document
---


# Purpose

This function takes accelerometer data acquired from the Samsung Galaxy S Smartphone
and provides a tidy data set consisting of the average for each mean and standard deviation value for each activity performed by each subject.  The tidy data is saved to a file named __tidydata.txt__ in your working directory.

# Requirements for using run_analysis

The required files are located:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset needs to be downloaded, and the files unzipped in your working directory.
 
The names of the files that are required by this function are:

* __y_test.txt__ - Activities performed by the subjects during the test phase
* __subject_test.txt__ - Subjects who performed the activities during the test phase
* __X_test.txt__ - Data acquired from the Samsung phone for each subject/activity during the test phase
 * __y_train.txt__ - Activities performed by the subjects during the training phase
 * __X_train.txt__ -  Data acquired from the Samsung phone for each subject/activity during the training phase
 * __subject_train.txt__ - Subjects who performed the activities during the training phase

# How to Run

To run the function type: run_analysis()

The tidy data is saved to a file named __tidydata.txt__ in your working directory.