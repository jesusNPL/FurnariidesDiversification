source("run_diversification_analyses.R")

# On a sample of 500 trees

tree = "../../Phylogeny/furna_divTime_WO_1000trs_newNames.nex"

run_Morlon_models(tree, sampling_fraction = 0.9,
                  number_of_trees = 500)

run_PaleoEnv(tree, env_data_file = "./PaleoEnv/PastTemperature.txt",
             sampling_fraction = 0.9, number_of_trees = 500)

run_PaleoEnv(tree, env_data_file = "./PaleoEnv/PastAndeanAltitude.txt",
             sampling_fraction = 0.9, number_of_trees = 500)

run_PaleoEnv(tree, env_data_file = "./PaleoEnv/PastSeaLevel.txt",
             sampling_fraction = 0.9, number_of_trees = 500)

run_TreePar(tree, sampling_fraction = 0.9, grid = 1,
            number_of_trees = 500)

#run_DDD("furna_divTime_WO_MCC.nex", total_richness = 685, number_of_trees = 1)

