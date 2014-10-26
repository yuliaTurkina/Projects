Steps to clean data: 
1. Create one dataset by merging the training and the test sets 
2. Extracts only the measurements on the mean and standard deviation (by using data from the features.txt file) 
3. Merge test and train dataset for activity and subject data 
4. Merge activity, subject data and main dataset (from step 2) 
5. Get descriptive activity names (from activity_labels.txt file) and rename activities in the main data set 
6. Get descriptive variable names from features.txt file and appropriately labels the main data set
7. Group data by activity and subject variables, calculate mean for each measure in dataset
