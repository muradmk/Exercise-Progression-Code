# Exercise Progression Code Background.
I created this code in Python, then rewrote in R, to create personalized workout plans focused on progressive overload with the goal of increasing strength and hypertrophy. The basis of progression in this approach is based on the 1 repetition maximum value, or the 1 rep max, using the formula by Matt Brzycki (1998).

In a systematic review and meta-analysis of exercise protocols by Schoenfeld et al. (2017), the authors observed that high-load training produced the greatest strength increases, while hypertrophy was more closely tied to the volume (sets * reps * weight) of the training. Given that this code aims to maximize strength, it does coincidentally lead to progressively increased training volume over time, but the main focus is on strength gains, as measured by the 1 rep max.

## Here is a brief non-technical description of what the code aims to do, and a step-by-step technical description follows:

### Non-technical description:

This code defines a function that generates a workout plan for a specified period of time, with the goal of increasing strength as measured by the 1 rep max metric. The function takes a list of exercises, the number of weeks for the plan, and the number of sets for each exercise as input.

For each exercise in the list, the function calculates the 1 rep max (1RM), the projected 1RM for each week, the number of reps, the weight value, and the volume value for each exercise. It then creates a dataframe for each exercise with the calculated values, and concatenates all the dataframes together into a single dataframe that contains the progression of the exercise plan for each exercise specified. The final output is a dataframe which has the progression of the exercise plan for each exercise specified

This function can be called by passing a list of dictionaries, where each dictionary contains information about an exercise. Each exercise dictionary should contain the following keys: name, one_rep_max, growth, and reps.

For example, to create a workout plan for bench press, squats, and cleans exercises for 16 weeks, with a starting one rep max of 250 for bench press, 200 for squats, and 135 for cleans, a growth rate of 1.01 for bench press, 1.05 for squats, and 1.01 for cleans, and a starting number of reps of 5 for bench press, 8 for squats, and 12 for cleans, you can use the following code:


### Technical Description
The code (python and R) defines a function exercise_projection(exercises, n_weeks=16, sets=3) that takes a list of exercises, the number of weeks and number of sets as inputs and returns a dataframe that contains the progression of exercise plan for each exercise specified.

The function (in python) does the following:

  - Initialize an empty list data that will later be used to store the dataframe for each exercise
  - Iterate over the list of exercises passed as an argument to the function
  - For each exercise, calculate the 1 rep max (oneRM) using the formula oneRM = weight/(1.0278 - 0.0278*reps)
  - Create a list week_no that contains the sequence of weeks, starting from 1 and ending at n_weeks
  - Initialize empty lists week1RM, rep_range, weight_val, volume_val
  - Iterate through the number of weeks
    - For each week, calculate the projected one rep max (proj_oneRM) by multiplying the current one rep max by the growth rate
    - Update the current one rep max to be the projected one rep max
    - Increment the reps by 1
    - if reps is greater than or equal to 10, set the reps to 6
    - Calculate the weight_val using the formula weight_val = round(proj_oneRM1.0278 - proj_oneRM0.0278*reps)
    - Append the calculated weight_val to the list weight_val
    - Append the current reps to the list rep_range
    - Append the current one rep max to the list week1RM
    - If reps is greater than or equal to 4 and less than or equal to 6 set sets to 4, else if reps is greater than or equal to 7 and less than or equal to 10 set sets to 3
    - Calculate the volume_val using the formula volume_val = round(weight_val[i] * rep_range[i] * sets)
    - Append the calculated volume_val to the list volume_val
  - Create a dataframe exercise_plan using the lists week_no, week1RM, rep_range, weight_val, volume_val
  - Rename the columns of the dataframe using the exercise name and the original column name separated by an underscore
  - Append the dataframe to the list data
  - Use the pd.concat() function to concatenate all the dataframes in the list data together into a single dataframe.
  - Return the final dataframe


