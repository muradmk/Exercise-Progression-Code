import pandas as pd

# Sample dictionary that is needed for the function to run
exercises = [{"name":"bench", "one_rep_max":250, "growth":1.01, "reps":5}, 
             {"name":"squats", "one_rep_max":200, "growth":1.05, "reps":8},


def exercise_projection(exercises, n_weeks=16, sets=3):
    # Initialize an empty list to store exercise data
    data = []
    for exercise in exercises:
        # Extract exercise information from dictionary
        exercise_name = exercise["name"]
        one_rep_max = exercise["one_rep_max"]
        growth = exercise["growth"]
        reps = exercise["reps"]
        # Create list of week numbers
        week_no = list(range(1, n_weeks+1))
        week1RM = []
        rep_range = []
        weight_val = []
        volume_val = []
        # Iterate through the number of weeks
        for i in range(n_weeks):
            # Calculate projected one rep max
            proj_oneRM = one_rep_max * growth
            one_rep_max = proj_oneRM
            reps += 1
            # Reset reps to 6 if they reach 10
            if reps >= 10:
                reps = 6
            # Calculate weight value
            weight_val.append(round(proj_oneRM*1.0278 - proj_oneRM*0.0278*reps))
            rep_range.append(round(reps))
            week1RM.append(round(one_rep_max))
            if reps >= 4 and reps <= 6:
                sets = 4
            elif reps >= 7 and reps <= 10:
                sets = 3
            #Calculate volume value
            volume_val.append(round(weight_val[i] * rep_range[i] * sets))
        # Create dataframe for the current exercise
        exercise_plan = pd.DataFrame({"week_no":week_no, "week1RM":week1RM, "rep_range":rep_range, "weight_val":weight_val, "volume_val":volume_val})
        # Add exercise name prefix to column names
        exercise_plan = exercise_plan.rename(columns=lambda x: exercise_name + "_" + x)
        # Append exercise data to the list
        data.append(exercise_plan)
    # Concatenate all the exercise dataframes             
    final_plan = pd.concat(data, axis=1)
    return final_plan
