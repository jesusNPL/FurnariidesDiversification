source("run_diversification_analyses.R")
library("ape")


path_trees = c("trees/ftree627.nex"
               #"trees/ftree632.nex"    # j.o8630405
               #"trees/ftree635.nex"    # j.o8630399
               #"trees/ftree641.nex",
               #"trees/ftree768.nex",
               #"trees/ftree912.nex"
               )

## Number of tips per subtree
tree_sizes = sapply(path_trees, function(x){
    Ntip(read.nexus(x)[[1]])
})

## Percentage of species sampled per subtree
sampling_fraction = 0.9

## Observed + Unobserved richness per subclade
total_richness = tree_sizes + ceiling(tree_sizes * (1 - sampling_fraction) )

mapply(run_DDD,
       tree_file       = path_trees,
       total_richness  = total_richness,
       number_of_trees = 10)               # ncores -1 -- for testing
