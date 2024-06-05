# loads libraries
library(here)
# the user should update the park name and the decided probability cutoffs
park <- "NOCA"
cutoffs <- c(0, .4, .4, NA, 0, 0, NA, 0)
# disturbance class information
disturbance_subset <- c(1, 2, 3, 4, 5, 7, 9, 16)
disturbances <- c("Annual Variability", # (1)
                  "Avalanche", # (2)
                  "Blowdown", # (3)
                  "Clearing", # (4)
                  "Defoliation", # (5)
                  "Development", # (6)
                  "Fire", # (7)
                  "Ice Damage", # (8)
                  "Mass Movement", # (9)
                  "Post Avalanche", # (10)
                  "Post Blowdown", # (11)
                  "Post Clearing", # (12)
                  "Post Defoliation", # (13)
                  "Post Fire", # (14)
                  "Post Mass Movement", # (15)
                  "Riparian Change", # (16)
                  "Water") # (17)
disturbances <- disturbances[disturbance_subset]
# loads the model predictions for the testing set
pred <- data.frame(read.csv(here(park, "model_accuracy", "predicted.csv")))
# loads the model voting breakdown for the testing set
vote <- data.frame(read.csv(here(park, "model_accuracy", "votes.csv")))
colnames(vote) <- disturbances
# loads the true labels for the testing set
labl <- data.frame(read.csv(here(park, "model_accuracy", "y_test.csv")))
# creates a data frame to store results
results <- data.frame(matrix(NA, length(disturbances), 2))
# loops through the disturbance types
for (i in 1:length(disturbances)) {
  # gets the probability cutoff for the current disturbance type
  cutoff <- cutoffs[i]
  if (is.na(cutoff)) {
    next
  }
  # gets the current disturbance
  disturbance <- disturbances[i]
  # subsets the loaded data by the current disturbance type
  vote_subset <- vote[labl == disturbance,]
  pred_subset <- pred[labl == disturbance,, drop = FALSE]
  labl_subset <- labl[labl == disturbance,, drop = FALSE]
  # creates variables to store results
  numer <- 0
  denom <- 0
  # loops through the model voting breakdown
  for (j in 1:nrow(vote_subset)) {
    # if a classification was made above the user-defined cutoff,
    # increment the denominator
    if (max(vote_subset[j,]) >= cutoff) {
      denom <- denom + 1
      # if the model label matches the actual label,
      # increment the numerator
      if (pred_subset[j, 1] == labl_subset[j, 1]) {
        numer <- numer + 1
      }
    }
  }
  # store the results
  results[i, 1] <- numer
  results[i, 2] <- denom
}
# calculate the overall classification accuracy and the 
# percent of patches classified
total_numer <- sum(results[,1], na.rm = TRUE)
total_denom <- sum(results[,2], na.rm = TRUE)
total_patches <- nrow(labl)
print("the total classification accuracy over the testing set is:")
print(total_numer / total_denom)
print("the percent classified is:")
print(total_denom / total_patches)

