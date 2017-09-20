# Getting_and_cleaning_data
This repository contains my run_analysis script and its codebook. The run_analyisis script produces a tidy data set from the data provided in the UCI HAR Dataset. The variables are the mean values for each of the mean and standard deviation variables in the original data sets, grouped by subject and activity. The Script works as follows:

-Creates function readt() that takes as input the tail of the file directory of one of the text files, and creates a named data frame in R. 
-Creates functions Activity() and subject() that renames the variables of the subject and activity tables from "V1" to activity and subject.
-Then following the steps of the assignment:
#1 combines the accelorometer/gyroscope data with the activity and subject data, for both test and train datasets, then combines the two into a longer data frame.
#2 renames the variables using the feature.txt data, and selects mean and std columns with. subsetting by grep output fr this regex.
#3 creates yo function which transforms a value of x into the corresponding activity name from activity.txt. yo is applied to the Activity column of the dataframe, and replaces the old column
#4 Tidies up some of the special characters in the column names to underscores- note that I already applied the feature names to the columsn in step 2.
#5 Groups the data by subject and activity, and uses summarize() to create a new dataset from the means of each variable.
