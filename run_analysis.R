library(tidyverse)

# Read activity labels and feature names to allow for properly labeling the datasets

activity_labels <- read.delim("01 - RAW-DATA/activity_labels.txt",
			      header=FALSE,
			      sep=" ") %>%
	rename(Label = V1,
	       Activity.Name=V2)

feature_names <- read.delim("01 - RAW-DATA/features.txt",
					       header=FALSE,
					       sep=" ") %>%
	rename(Activity.Label = V1,
	       Feature=V2)

# Read training dataset and merge into single dataframe

subject_train <- read.delim("01 - RAW-DATA/train/subject_train.txt",
			    header=FALSE) %>%
	rename(Subject = V1)

activities_train <- read.delim("01 - RAW-DATA/train/y_train.txt",
			       header=FALSE) %>%
	rename(Label = V1) %>%
	inner_join(activity_labels)

measurements_train <- read.delim("01 - RAW-DATA/train/X_train.txt",
				 sep = "",
				 header=FALSE,
				 stringsAsFactors = FALSE,
				 col.names = feature_names$Feature) 

training_data <- cbind(subject_train, activities_train, measurements_train)

# Read test dataset and merge into single dataframe

subject_test <- read.delim("01 - RAW-DATA/test/subject_test.txt",
			    header=FALSE) %>%
	rename(Subject = V1)

activities_test <- read.delim("01 - RAW-DATA/test/y_test.txt",
			       header=FALSE) %>%
	rename(Label = V1) %>%
	inner_join(activity_labels)

measurements_test <- read.delim("01 - RAW-DATA/test/X_test.txt",
				 sep = "",
				 header=FALSE,
				 stringsAsFactors = FALSE,
				 col.names = feature_names$Feature) 

test_data <- cbind(subject_test, activities_test, measurements_test)

# Combine training and test dataset to one lage dataset

full_data <- rbind(training_data, test_data)

filtered_data <- full_data %>%
	select(matches("Subject|Label|Activity.Name|.*\\.mean.*|.*\\.std.*"))
