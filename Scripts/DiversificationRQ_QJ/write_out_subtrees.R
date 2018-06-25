## Write out the trees in the RData file as nexus files that can be
## used by the run_xxx functions inside runAnalysis

library("ape")

# Read data
load("../../Phylogeny/Phylogenies_nodiv.RData")

# Write trees out
ape::write.nexus(ftree627, file = "trees/ftree627.nex")
ape::write.nexus(ftree632, file = "trees/ftree632.nex")
ape::write.nexus(ftree635, file = "trees/ftree635.nex")
ape::write.nexus(ftree641, file = "trees/ftree641.nex")
ape::write.nexus(ftree768, file = "trees/ftree768.nex")
ape::write.nexus(ftree912, file = "trees/ftree912.nex")
