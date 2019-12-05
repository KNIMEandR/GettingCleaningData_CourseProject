---
title: "README"
author: "KNIMEandR"
date: "2019-12-05"
output: html_document
---

# Introduction
This file shall accompany the "run_analysis.R" file as it explains the main steps for preprocessing the wearable dataset. The script makes heavy use of the tidyverse (i.e. dplyr) functions for working with dataframes as well as the %>% (pipe) operator to chain transformations.

# Analysis script description

The major sections of the script are marked by comments and the same comments are used as section sub-headings throught this section for easier cross-referencing 

## Read activity labels and feature names to allow for properly labeling the datasets

In the very first step of the analysis script the files containing the descriptive activity labels as well as the feature names to be used as column names are imported into the data.frames "activity_labels" and "feature_names" as they are used immediately when importing the training and test dataset

## Read training dataset and merge into single dataframe

In this step the training data is imported and enriched with the data from "activity_labels" and "feature_names". Finally all three intermediate dataframes are combined to one dataframe "measurements_train" containing all measurements of the training dataset.

## Read test dataset and merge into single dataframe

This step imports and enriches the test dataset as described above for the training dataset. The final data.frame is named "test_data"

## Combine training and test dataset to one lage dataset

The next section comprises two processing steps. First the training and test dataset are combined into a single data.frame (full_data) which is then filtered to only contain information about Subject and activity together with all variables containing "mean" or "std" (standard deviation) in their column name. Finally the dataset is converted into a tidy long format (filtered_long) to have both versions available for further processing.

## Aggregate data with average of each variable per activity and subject

The second last section performs the task of aggregating the filtered dataset by Subject and Activity. For clear discriminability all variable names in the resulting dataset (aggregated_data) have been modified to start with "average". As for the filtered dataset this dataset is converted into a tidy long format (filtered_long) as well to have both versions available for further processing.

## Export as .csv file for interoperability

Last but not least both datasets (filtered and aggregated) are exported as .csv-files both in the wide and long format. Information on how to re-import these files into R is given in the CodeBook.md
