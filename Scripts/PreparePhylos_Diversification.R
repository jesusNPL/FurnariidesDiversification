library(ape)
library(phytools)
library(geiger)
library(nodiv)

## phylogenies
ftr2 <- read.nexus("Data/nodivRanges/fPHYLOnovid.nex")

## Load nodiv results and select node divergence
load("Data/nodivRanges/nodivResults.RData")
summary(frd1dg)
plot(frd1dg)
plotSOS(frd1dg)

remover <- ls()
##### Prune phylogenies based on the number of nodes identified with nodiv #####
nodos <- c(627, 632, 635, 641, 768, 912)

ftree627 <- lapply(ftr2, extract.clade, node = nodos[1])
class(ftree627) <- "multiPhylo"
length(ftree627[[1]]$tip.label)

ftree632 <- lapply(ftr2, extract.clade, node = nodos[2])
class(ftree632) <- "multiPhylo"
length(ftree632[[1]]$tip.label)

ftree635 <- lapply(ftr2, extract.clade, node = nodos[3])
class(ftree635) <- "multiPhylo"
length(ftree635[[1]]$tip.label)

ftree641 <- lapply(ftr2, extract.clade, node = nodos[4])
class(ftree641) <- "multiPhylo"
length(ftree641[[1]]$tip.label)

ftree768 <- lapply(ftr2, extract.clade, node = nodos[5])
class(ftree768) <- "multiPhylo"
length(ftree768[[1]]$tip.label)

ftree912 <- lapply(ftr2, extract.clade, node = nodos[6])
class(ftree912) <- "multiPhylo"
length(ftree912[[1]]$tip.label)

# Save
rm(list = remover)
save.image("Data/Phylogeny/Phylogenies_nodiv.RData")
