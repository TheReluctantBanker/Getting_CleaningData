Getting_CleaningData
====================

## Read Me For the Course Project on Getting and Cleaning Data

### The following files were used for the analysis:
*X_train.txt and X_test.txt : the datasets having the training data and test data respectively
* subject_train.txt and subject_test.txt: the datasets having the subject numbers
*y_train.txt and y_test.txt: the datasets having the activity codes

###The key steps for the project are listed below:
* Read the training and test data into R. ( 7352 rows and 561 columns)
* Read the datasets for training subjects and test subjects into R (2947 rows and 561 columns)
* Read the datasets for the training activity codes and test activity codes into R 
*The Activity codes in the training activity file and test activity file are renamed with descriptive levels ("Walking", 
"Walking Upstairs","Walking Downstairs", "Sitting", "Standing", "Laying")
*Created  a merged dataset (combined.data) which has the training data, test data, subject numbers and the activity levels. The
dimensions of this dataset are 10299 rows (7352 rows + 2947 rows) and 563 columns
*Extract only those columns from this merged dataset which pertain to mean and standard deviaiton measures. Out of 561 measures,
only 79 are measures of mean and standard deviation.
*Hence, we end up with the dataset (combined.data.final) having 10299 rows and 81 columns ( 1 column for subject, 1 for activity
and the remaining 79 measures)
*using the aggregate command, the measures are aggregated for a combination of subject*activity (tidy.dataset
*There are 6 activity levels and 30 subjects, hence 180 combinations
*the tidy data set thus created has 180 rows and 81 columns


