run_analysis.R script explained.
==============
This is a file which explains how the run_analysis.R file works.
To begin with 8 dataframes are created by reading in files from the "UCI HAR Dataset" folder which was downloaded to the working directory.
Note this script expects the folder "UCI HAR Dataset" to be in the working directory. 

3 of the files contain training data and 3 contain test data. The dataframes and the corresponding files they come from are given below:

Test:  
X_test from "UCI HAR Dataset/test/X_test.txt"
Y_test from "UCI HAR Dataset/test/Y_test.txt"
subject_test from "UCI HAR Dataset/subject_test.txt"

Train:  
X_train from "UCI HAR Dataset/train/X_train.txt"
Y_train from "UCI HAR Dataset/train/Y_train.txt"
subject_train from "UCI HAR Dataset/train/subject_train.txt"


The data in these two files are commmon to both test and train:  
activity_labels from "UCI HAR Datset/activity_labels.txt"
features from "UCI HAR Dataset/features.txt"

We first combine all the test data using cbind i.e. column bind to create a dataframe called merge test. 
Y_test will become the first column with a column name "subject". 
Y_train will become the second column with a column name called "activity". X_test will be stacked next to these two columns.  
It will have the same number of rows but 561 columns.

Next we combine all the training data using cbind to create dataframe called mergetrain. 
Basically subject_train will become the first column with a column name called "subject". Y_train will become the second column with a column   name called "activity". 
X_train will be stacked next to these two columns. 

Both mergetest and mergetrain will have the same number of columns but different rows. 
We stack them on top of each other using rbind and call the resulting dataframe mergeboth.

Now we have all the data in one big dataframe. The second column of our features dataframe contains the names of the mesurements which comprises the X_test and X_train tables. 
So we flip the features on it's side; extract the second row; and assign it to last 561 colnames of our mergeboth dataframe.

We then use subsetting to extract just the first two columns and those columns containing mean() or std() in the column names. This gives us  
68 columns.

Next we load the dplyr library to transform the dataframe to tbl_dataframe and call it merg_tbl.  using the information in the activity_labels we replace the "activity" 
integer values in merg_tbl with the actual activity descriptions like WALKING etc.

Finally clean up the column names a bit by removing the "()" and "-" ; group the dataframe by subject and activity. i.e. each subject and activity pair will be a group and apply the summarize_each function to get the mean values of the all the columns for each of these groups.

After all this we get the tidy_Data dataframe.  Here are the first 10  
rows and first 6 columns; showing that the data set is indeed tidy.


  subject           activity tBodyAcc.mean.X tBodyAcc.mean.Y tBodyAcc.mean.Z
1       1             LAYING       0.2215982    -0.040513953      -0.1132036
2       1            SITTING       0.2612376    -0.001308288      -0.1045442
3       1           STANDING       0.2789176    -0.016137590      -0.1106018
4       1            WALKING       0.2773308    -0.017383819      -0.1111481
5       1 WALKING_DOWNSTAIRS       0.2891883    -0.009918505      -0.1075662
6       1   WALKING_UPSTAIRS       0.2554617    -0.023953149      -0.0973020

