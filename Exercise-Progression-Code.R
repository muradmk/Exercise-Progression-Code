
# Each exercise data frame should contain the following columns: name, one_rep_max, growth, and reps.
# For example, to create a workout plan for bench press, squats, and cleans exercises for 16 weeks, 
# with a starting one rep max of 250 for bench press, 200 for squats, and 135 for cleans, a growth rate
# of 1.01 for bench press, 1.05 for squats, and 1.01 for cleans, and a starting number of reps of 5 for bench press, 
# 8 for squats, and 12 for cleans, you can use the following sample code:

exercises <- list(data.frame(name="bench", one_rep_max=250, growth=1.01, reps=5), 
                  data.frame(name="squats", one_rep_max=200, growth=1.05, reps=8),
                  data.frame(name="cleans", one_rep_max=135, growth=1.01, reps=12)
                  )

exercise_projection <- function(exercises, n_weeks = 16, sets = 3){
  # Initialize an empty list to store exercise data
  data <- list()
  # Iterate through each exercise
  for(i in 1:length(exercises)){
    exercise <- exercises[[i]]
    # Extract exercise information
    exercise_name <- exercise$name
    one_rep_max <- exercise$one_rep_max
    growth <- exercise$growth
    reps <- exercise$reps
    # Create sequence of week numbers
    week_no <- seq(1,n_weeks,1)
    week1RM <- c()
    rep_range <- c()
    weight_val <- c()
    volume_val <- c()
    # Iterate through the number of weeks
    for(i in 1:n_weeks){
      # Calculate projected one rep max
      proj_oneRM <- one_rep_max * growth
      one_rep_max <- proj_oneRM
      reps <- reps + 1
      # Reset reps to 6 if they reach 10
      if(reps >= 10){
        reps <- 6
      }
      # Calculate weight value
      weight_val[i] <- round(proj_oneRM*1.0278 - proj_oneRM*0.0278*reps)
      rep_range[i] <- round(reps)
      week1RM[i] <- round(one_rep_max)
      if(reps >= 4 && reps <= 6){
        sets <- 4
      }else if(reps >= 7 && reps <= 10){
        sets <- 3
      }
      #Calculate volume value
      volume_val[i] <- round(weight_val[i] * rep_range[i] * sets)
    }
    # Create dataframe for the current exercise
    exercise_plan <- data.frame(week_no,week1RM,rep_range,weight_val,volume_val)
    # Add exercise name prefix to column names
    colnames(exercise_plan) <- c(paste0(exercise_name,"_week_no"),paste0(exercise_name,"_week1RM"), paste0(exercise_name,"_rep_range"), paste0(exercise_name,"_weight_val"), paste0(exercise_name,"_volume_val"))
    # Append exercise data to the list
    data[[i]] <- exercise_plan
  }
  # Merge all exercise dataframes into one
  final_plan <- Reduce(function(x, y) merge(x, y, by = "week_no"), data)
  return(final_plan)
}

workout_plan <- exercise_projection(exercises)
