source("run_diversification_analyses.R")

path_trees = dir("trees", full.names = TRUE)

lapply(X = path_trees, FUN = run_TreePar,
       sampling_fraction = 0.9, number_of_trees = 100, grid = 1)
