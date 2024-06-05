# Landscape-Disturbance-Classification
Tools for building a machine learning model to label landscape disturbance patches in Mount Rainier, Olympic, and North Cascades National Parks.

## Introduction
The North Coast and Cascades Network, in partnership with Oregon State University, uses LandTrendr, a machine learning algorithm that uses satellite imagery to detect landscape change, to find patches of land that have been disturbed in the three National Parks mentioned above. This repositoy provides a workflow for training a random forest model to label those disturbance patches as avalanches, blowdowns, clearing, etc.

## Files
There are four scripts in this repository:

1. gee_generate_predictors.txt: calculates geometric predictor variables for disturbance patches
2. rf_variable_selection.Rmd: helps the user remove correlated predictor variables from the model
3. rf_training.Rmd: trains and tests the random forest model on labeled data
4. rf_labeling.Rmd: applies the trained random forest model on unlabeled, unseen disturbance patches

The data is contained within each of the park folders (MORA, OLYM, and NOCA) and flows through the sub-folders throughout the process of building the model. Look at the SOP and the Report in the documentation for more detailed information on how to run the scripts.

## Notes
This repository was developed by Dan Wexler under the supervision of John Boetsch and Natasha Antonova. Please email danwexler32@gmail.com with any questions.