---
title: "CodeBook"
author: "Lars Röglin"
date: "2 12 2019"
output: html_document
---

# Preparations outside R

The zip file with the raw-data has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extracted to the folder "01 - RAW-DATA" in the project directory.

# Preprocessing

## Read data and clean variable names

* From the dataset description the files activity_labels.txt and features.txt were imported into corresponding dataframes. This is used for immediate joining of the activity label with the human readable activity name as well as an appropriate labeling of the columns of the 561 features.

* The training dataset comprising the files "01 - RAW-DATA/train/subject_train.txt", 01 - RAW-DATA/train/X_train.txt" and "01 - RAW-DATA/train/y_train.txt" has been imported into separate data.frames which have been cleaned and merged to a single data.frame (training_data).

* The test dataset comprising the files "01 - RAW-DATA/test/subject_test.txt", 01 - RAW-DATA/train/X_test.txt" and "01 - RAW-DATA/test/y_test.txt" has been imported into separate data.frames which have been cleaned and merged to a single data.frame (test_data).

* Both datasets have been combined to a single large dataframe containing all measurements (full_data)

## Extracting only measurements on mean and standard deviation

* The full dataset (full_data) has been reduced to only comprise the identifying features Subject, Label and Activity.Name and all Columns that either contain "mean" or "std" in the column name

* While the Median absolute deviation is also a measure of variance it is excluded from the filtered dataset

# Aggregation

* The filtered dataset from the last step has been grouped by Subject, Activity.Label and Activity.Name (reduntant but excludes both Activity Colums from being averaged). All collumns have been averaged using the mean function and renamed appropriately

# Export

* For interoperability and easier use in subsequent processing steps the filtered and aggregated datasets have been exported to .csv-files in the "02 - CLEANED DATA" folder in the project directory