source("run_diversification_analyses.R")

path_trees = dir("trees", full.names = TRUE)

lapply(X = path_trees, FUN = run_Morlon_models,
       sampling_fraction = 0.9, number_of_trees = 100)
