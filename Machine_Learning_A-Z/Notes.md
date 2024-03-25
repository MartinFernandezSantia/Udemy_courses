The Machine Learning Process:

- Data Pre-Processing
    . Import the data
    . Clean the data
    . Split into training and test sets

- Modeling
    . Build the model
    . Train the model
    . Make predictions

- Evaluation
    . Calculate performance metrics
    . Make a verdict

---------------------------------------------------------

Feature Scaling:
    - It's only applied to columns
    - Normalization: Take the minimum value of the column, subtract it
        from all values inside that column and then dividing the result
        between the result of the maximum value minus the minimum. This
        will result in a new column with values between 0 and 1.
        New X = (X - X_min) / (X_max - X_min)
    - Standardization: Subtract the average value of the column from
        all rows inside said column, and then divide the result by the
        standard deviation. This will most likely result in a new
        column with values between -3 and 3, unless we have some
        extreme values which may step outside said range.
        New X = (X - μ) / 𝜎
        μ = X_avg
        𝜎 = standard deviation:
            1. Find the mean (average) of the numbers in the list.
            2. For each number in the list, find the difference
                between the number and the mean, and square the result.
            3. Find the mean (average) of these squared differences.
            4. Take the square root of the result from step 3.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

In any dataset (datasets can be seen as DB tables) which you're going to use in order to train an ML model, there are features / independant variables and a dependant variable. The features are the columns that we want to use in order to predict which value will the dependant variable take.

---

Taking care of missing data:

    - Replace the missing values by the average value of their respective columns.
