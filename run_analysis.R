library(tidyverse)

# Read activity labels and feature names to allow for properly labeling the datasets

activity_labels <- read.delim("activity_labels.txt",
			      header=FALSE,
			      sep=" ") %>%
	rename(Activity.Label = V1,
	       Activity.Name = V2)

feature_names <- read.delim("features.txt",
					       header=FALSE,
					       sep=" ") %>%
	rename(Activity.Label = V1,
	       Feature = V2)

# Read training dataset and merge into single dataframe

subject_train <- read.delim("train/subject_train.txt",
			    header=FALSE) %>%
	rename(Subject = V1)

activities_train <- read.delim("train/y_train.txt",
			       header=FALSE) %>%
	rename(Activity.Label = V1) %>%
	inner_join(activity_labels)

measurements_train <- read.delim("train/X_train.txt",
				 sep = "",
				 header=FALSE,
				 stringsAsFactors = FALSE,
				 col.names = feature_names$Feature) 

training_data <- cbind(subject_train, activities_train, measurements_train)

# Read test dataset and merge into single dataframe

subject_test <- read.delim("test/subject_test.txt",
			    header=FALSE) %>%
	rename(Subject = V1)

activities_test <- read.delim("test/y_test.txt",
			       header=FALSE) %>%
	rename(Activity.Label = V1) %>%
	inner_join(activity_labels)

measurements_test <- read.delim("test/X_test.txt",
				 sep = "",
				 header=FALSE,
				 stringsAsFactors = FALSE,
				 col.names = feature_names$Feature) 

test_data <- cbind(subject_test, activities_test, measurements_test)

# Combine training and test dataset to one lage dataset

full_data <- rbind(training_data, test_data)

filtered_data <- full_data %>%
	select(matches("Subject|Label|Activity.Name|.*\\.mean.*|.*\\.std.*"))

filtered_long <- filtered_data %>%
	pivot_longer(c(-Subject, -Activity.Label, -Activity.Name),
		     	names_to = "Measurement",
			values_to = "Value")


# Aggregate data with average of each variable per activity and subject

aggregated_data <- filtered_data %>%
	group_by(Subject, Activity.Label, Activity.Name) %>%
	summarize_all(funs(mean = mean(., na.rm = TRUE))) %>%
	ungroup() %>%
	setNames(paste("average", colnames(.), sep = ".")) %>%
	rename(Subject = average.Subject,
	       Activity.Label = average.Activity.Label,
	       Activity.Name = average.Activity.Name) 

aggregated_long <- aggregated_data %>%
	pivot_longer(c(-Subject, -Activity.Label, -Activity.Name),
		     names_to = "Measurement",
		     values_to = "Value")

# Export as .csv file for interoperability

write.table(filtered_data,
	  file="cleaned_filtered.csv",
	  quote = FALSE,
	  sep=",",
	  dec=".",
	  row.names = FALSE)

write.table(filtered_long,
	    file="cleaned_filtered_long.csv",
	    quote = FALSE,
	    sep=",",
	    dec=".",
	    row.names = FALSE)

write.table(aggregated_data,
	  file="cleaned_aggregated.csv",
	  quote=FALSE,
	  sep=",",
	  dec=".",
	  row.names = FALSE)

write.table(aggregated_data,
	    file="cleaned_aggregated_long.csv",
	    quote=FALSE,
	    sep=",",
	    dec=".",
	    row.names = FALSE)
