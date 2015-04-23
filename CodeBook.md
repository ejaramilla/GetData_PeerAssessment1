
# Code Book

## Data

### Summary
The data was taken from UCI's Machine Learning Repository <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.  

It comes from the "Human Activity Recognition Using Smartphones Data Set" which is described as:

> Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Below is an explanation of the data from the website:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Files in the Dataset

- `README.md` - Description of the repo
- `CodeBook.md` - This file which describes the data and the methodologies used to clean and filter it
- `run_analysis.R` - the program and will download, combine, filter, cleanse and finally aggregate and output the final dataset.
- `results.txt` - the final dataset that results from running run_analysis.R

The following is a descriptions of the files from the `README.txt` contained in the ZIP file <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> which gets downloaded as part of this data analysis:

> - 'README.txt'
> - 'features_info.txt': Shows information about the variables used on the feature vector.
> - 'features.txt': List of all features.
> - 'activity_labels.txt': Links the class labels with their activity name.
> - 'train/X_train.txt': Training set.
> - 'train/y_train.txt': Training labels.
> - 'test/X_test.txt': Test set.
> - 'test/y_test.txt': Test labels.

> The following files are available for the train and test data. Their descriptions are equivalent.

> - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
> - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
> - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
> - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

The files in the Inertial Signals folders are not necessary for this exercise are not required and have been omitted from processing.

## Transformations & Clean Up

### Summary
The two datasets from the *test* and *train* groups (which contained 3 files per group) were combined into 1 main dataset.  The main dataset had lookup values replaced with their descriptions, and variable names replaced with more understandable descriptions.

### Details
This was accomplished by first combining all the files based on their like filename and content:

- `train/X_train.txt` + `test/X_test.txt`
- `train/y_train.txt` + `test/y_test.txt`
- `train/subject_train.txt` + `test/subject_test.txt`

The `activity_labels.txt` file was used to replace the coded numbers in `y_[train/test].txt` with their true descriptions.

The `features.txt` file gave the column description of the `X_[train/test].txt`.  And only those column names containing `mean()` (for the mean value) or `std()` (for the standard deviation) were kept and crossreferenced to filter the `train/X_train.txt` + `test/X_test.txt` dataset.

The column names from the `features.txt` file were also cleansed to give a more descriptive label.  This included labeling the measurements that came from Three dimensional signals (3D) vs Fast Fourier Transforms (FFT) and expanding the abbreviations of the columns to provide better readability.

Finally after the combined dataset was filtered and cleansed, the mean of each of the columns were computed by the grouping the combinations of the Subject and their ActivityType.

## Variables

1. **Subject**                                   - The ID number of the subject tested
2. **ActivityType**                              - The type of activity the person was performing
3. **3D-BodyAccelerometer-Mean-X**               - The mean of the X-coordinate measured from the Body Accelerometer (Three dimensional signal)
4. **3D-BodyAccelerometer-Mean-Y**               - The mean of the Y-coordinate measured from the Body Accelerometer (Three dimensional signal)
5. **3D-BodyAccelerometer-Mean-Z**               - The mean of the Z-coordinate measured from the Body Accelerometer (Three dimensional signal)
6. **3D-BodyAccelerometer-SD-X**                 - The standard deviation of the X-coordinate measured from the Body Accelerometer (Three dimensional signal)
7. **3D-BodyAccelerometer-SD-Y**                 - The standard deviation of the Y-coordinate measured from the Body Accelerometer (Three dimensional signal)
8. **3D-BodyAccelerometer-SD-Z**                 - The standard deviation of the Z-coordinate measured from the Body Accelerometer (Three dimensional signal)
9. **3D-GravityAccelerometer-Mean-X**            - The mean of the X-coordinate measured from the Gravity Accelerometer (Three dimensional signal)
10. **3D-GravityAccelerometer-Mean-Y**           - The mean of the Y-coordinate measured from the Gravity Accelerometer (Three dimensional signal)
11. **3D-GravityAccelerometer-Mean-Z**           - The mean of the Z-coordinate measured from the Gravity Accelerometer (Three dimensional signal)
12. **3D-GravityAccelerometer-SD-X**             - The standard deviation of the X-coordinate measured from the Gravity Accelerometer (Three dimensional signal)
13. **3D-GravityAccelerometer-SD-Y**             - The standard deviation of the Y-coordinate measured from the Gravity Accelerometer (Three dimensional signal)
14. **3D-GravityAccelerometer-SD-Z**             - The standard deviation of the Z-coordinate measured from the Gravity Accelerometer (Three dimensional signal)15. 3D-BodyAccelerometerJerk-Mean-X         - The mean of the X-coordinate measured from the Body Accelerometer Jerk (Three dimensional signal)
16. **3D-BodyAccelerometerJerk-Mean-Y**          - The mean of the Y-coordinate measured from the Body Accelerometer Jerk (Three dimensional signal)
17. **3D-BodyAccelerometerJerk-Mean-Z**          - The mean of the Z-coordinate measured from the Body Accelerometer Jerk (Three dimensional signal)
18. **3D-BodyAccelerometerJerk-SD-X**            - The standard deviation of the X-coordinate measured from the Body Accelerometer Jerk (Three dimensional signal)
19. **3D-BodyAccelerometerJerk-SD-Y**            - The standard deviation of the Y-coordinate measured from the Body Accelerometer Jerk (Three dimensional signal)
20. **3D-BodyAccelerometerJerk-SD-Z**            - The standard deviation of the Z-coordinate measured from the Body Accelerometer Jerk (Three dimensional signal)
21. **3D-BodyGyroscope-Mean-X**                  - The mean of the X-coordinate measured from the Body Gyroscope (Three dimensional signal)
22. **3D-BodyGyroscope-Mean-Y**                  - The mean of the Y-coordinate measured from the Body Gyroscope (Three dimensional signal)
23. **3D-BodyGyroscope-Mean-Z**                  - The mean of the Z-coordinate measured from the Body Gyroscope (Three dimensional signal)
24. **3D-BodyGyroscope-SD-X**                    - The standard deviation of the X-coordinate measured from the Body Gyroscope (Three dimensional signal)
25. **3D-BodyGyroscope-SD-Y**                    - The standard deviation of the Y-coordinate measured from the Body Gyroscope (Three dimensional signal)
26. **3D-BodyGyroscope-SD-Z**                    - The standard deviation of the Z-coordinate measured from the Body Gyroscope (Three dimensional signal)
27. **3D-BodyGyroscopeJerk-Mean-X**              - The mean of the X-coordinate measured from the Body Gyroscope Jerk (Three dimensional signal)
28. **3D-BodyGyroscopeJerk-Mean-Y**              - The mean of the Y-coordinate measured from the Body Gyroscope Jerk (Three dimensional signal)
29. **3D-BodyGyroscopeJerk-Mean-Z**              - The mean of the Z-coordinate measured from the Body Gyroscope Jerk (Three dimensional signal)
30. **3D-BodyGyroscopeJerk-SD-X**                - The standard deviation of the X-coordinate measured from the Body Gyroscope Jerk (Three dimensional signal)
31. **3D-BodyGyroscopeJerk-SD-Y**                - The standard deviation of the Y-coordinate measured from the Body Gyroscope Jerk (Three dimensional signal)
32. **3D-BodyGyroscopeJerk-SD-Z**                - The standard deviation of the Z-coordinate measured from the Body Gyroscope Jerk (Three dimensional signal)
33. **3D-BodyAccelerometerMagnitude-Mean**       - The mean of the Magnitude measured from the Body Accelerometer (Three dimensional signal)
34. **3D-BodyAccelerometerMagnitude-SD**         - The standard deviation of the Magnitude measured from the Body Accelerometer (Three dimensional signal)
35. **3D-GravityAccelerometerMagnitude-Mean**    - The mean of the Magnitude measured from the Gravity Accelerometer (Three dimensional signal)
36. **3D-GravityAccelerometerMagnitude-SD**      - The standard deviation of the Magnitude measured from the Gravity Accelerometer (Three dimensional signal)
37. **3D-BodyAccelerometerJerkMagnitude-Mean**   - The mean of the Magnitude measured from the Body Accelerometer Jerk (Three dimensional signal)
38. **3D-BodyAccelerometerJerkMagnitude-SD**     - The standard deviation of the Magnitude measured from the Body Accelerometer Jerk (Three dimensional signal)
39. **3D-BodyGyroscopeMagnitude-Mean**           - The mean of the Magnitude measured from the Body Gyroscope (Three dimensional signal)
40. **3D-BodyGyroscopeMagnitude-SD**             - The standard deviation of the Magnitude measured from the Body Gyroscope (Three dimensional signal)
41. **3D-BodyGyroscopeJerkMagnitude-Mean**       - The mean of the Magnitude measured from the Body Gyroscope Jerk (Three dimensional signal)
42. **3D-BodyGyroscopeJerkMagnitude-SD**         - The standard deviation of the Magnitude measured from the Body Gyroscope Jerk (Three dimensional signal)
43. **FFT-BodyAccelerometer-Mean-X**             - The mean of the X-coordinate measured from the Body Accelerometer (Fast Fourier Transform)
44. **FFT-BodyAccelerometer-Mean-Y**             - The mean of the Y-coordinate measured from the Body Accelerometer (Fast Fourier Transform)
45. **FFT-BodyAccelerometer-Mean-Z**             - The mean of the Z-coordinate measured from the Body Accelerometer (Fast Fourier Transform)
46. **FFT-BodyAccelerometer-SD-X**               - The standard deviation of the X-coordinate measured from the Body Accelerometer (Fast Fourier Transform)
47. **FFT-BodyAccelerometer-SD-Y**               - The standard deviation of the Y-coordinate measured from the Body Accelerometer  (Fast Fourier Transform)
48. **FFT-BodyAccelerometer-SD-Z**               - The standard deviation of the Z-coordinate measured from the Body Accelerometer  (Fast Fourier Transform)
49. **FFT-BodyAccelerometerJerk-Mean-X**         - The mean of the X-coordinate measured from the Body Accelerometer Jerk (Fast Fourier Transform)
50. **FFT-BodyAccelerometerJerk-Mean-Y**         - The mean of the Y-coordinate measured from the Body Accelerometer Jerk (Fast Fourier Transform)
51. **FFT-BodyAccelerometerJerk-Mean-Z**         - The mean of the Z-coordinate measured from the Body Accelerometer Jerk (Fast Fourier Transform)
52. **FFT-BodyAccelerometerJerk-SD-X**           - The standard deviation of the X-coordinate measured from the Body Accelerometer Jerk (Fast Fourier Transform)
53. **FFT-BodyAccelerometerJerk-SD-Y**           - The standard deviation of the Y-coordinate measured from the Body Accelerometer Jerk (Fast Fourier Transform)
54. **FFT-BodyAccelerometerJerk-SD-Z**           - The standard deviation of the Z-coordinate measured from the Body Accelerometer Jerk (Fast Fourier Transform)
55. **FFT-BodyGyroscope-Mean-X**                 - The mean of the X-coordinate measured from the Body Gyroscope (Fast Fourier Transform)
56. **FFT-BodyGyroscope-Mean-Y**                 - The mean of the Y-coordinate measured from the Body Gyroscope (Fast Fourier Transform)
57. **FFT-BodyGyroscope-Mean-Z**                 - The mean of the Z-coordinate measured from the Body Gyroscope (Fast Fourier Transform)
58. **FFT-BodyGyroscope-SD-X**                   - The standard deviation of the X-coordinate measured from the Body Gyroscope (Fast Fourier Transform)
59. **FFT-BodyGyroscope-SD-Y**                   - The standard deviation of the Y-coordinate measured from the Body Gyroscope (Fast Fourier Transform)
60. **FFT-BodyGyroscope-SD-Z**                   - The standard deviation of the Z-coordinate measured from the Body Gyroscope (Fast Fourier Transform)
61. **FFT-BodyAccelerometerMagnitude-Mean**      - The mean of the Magnitude measured from the Body Accelerometer (Fast Fourier Transform)
62. **FFT-BodyAccelerometerMagnitude-SD**        - The standard deviation of the Magnitude measured from the Body Accelerometer (Fast Fourier Transform)
63. **FFT-BodyAccelerometerJerkMagnitude-Mean**  - The mean of the Magnitude measured from the Body Accelerometer Jerk (Fast Fourier Transform)
64. **FFT-BodyAccelerometerJerkMagnitude-SD**    - The standard deviation of the Magnitude measured from the Body Accelerometer Jerk (Fast Fourier Transform)
65. **FFT-BodyGyroscopeMagnitude-Mean**          - The mean of the Magnitude measured from the Body Gyroscope (Fast Fourier Transform)
66. **FFT-BodyGyroscopeMagnitude-SD**            - The standard deviation of the Magnitude measured from the Body Gyroscope (Fast Fourier Transform)
67. **FFT-BodyGyroscopeJerkMagnitude-Mean**      - The mean of the Magnitude measured from the Body Gyroscope Jerk  (Fast Fourier Transform)
68. **FFT-BodyGyroscopeJerkMagnitude-SD**        - The standard deviation of the Magnitude measured from the Body Gyroscope Jerk (Fast Fourier Transform)
