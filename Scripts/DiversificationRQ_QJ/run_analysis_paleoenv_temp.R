source("run_diversification_analyses.R")

path_trees = c("trees/ftree627.nex", "trees/ftree632.nex", "trees/ftree635.nex",
               "trees/ftree641.nex", "trees/ftree768.nex", "trees/ftree912.nex")

lapply(X = path_trees, FUN = run_PaleoEnv,
       env_data_file = "./PaleoEnv/PastTemperature.txt",
       sampling_fraction = 0.9, number_of_trees = 100)
