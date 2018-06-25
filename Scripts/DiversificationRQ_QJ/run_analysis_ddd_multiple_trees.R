source("run_diversification_analyses.R")

path_trees = dir("trees", full.names = TRUE)

lapply(X = path_trees, FUN = run_DDD,
       total_richness = 685, number_of_trees = 100)
