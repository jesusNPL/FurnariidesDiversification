library(nodiv)
library(picante)
library(geiger)

library(raster)
library(sp)
library(letsR)
library(maptools)
library(rgdal)
library(rgeos)

##### Prepare data #####
franges <- readShapePoly("Data/Distribution/Furnarii_ranges_geo.shp")
ex <- extent(franges)

fphylo <- read.nexus("Data/Phylogeny/furna_divTime_WO_MCC_659spp_100reps_newNames.nex")

fpam1dg <- lets.presab(franges, xmn = -110.0817, xmx = -34.78897, ymn = -55.98222, ymx = 29.0965, 
                    resol = 1, count = TRUE)

#fpa1dg <- fpam1dg$Presence_and_Absence_Matrix
fpa1dg <- fPresAbs
dim(fpa1dg)
coords1dg <- fpa1dg[, 1:2]
colnames(coords1dg) <- c("Lon",	"Lat")
head(coords1dg)

# Change names in the PAM
newnames <- read.csv("/Users/jesusn.pinto-ledezma/Dropbox/Furnariides_taxonomy/NewNamesRanges.csv")
newnames <- as.character(newnames$UpdateinRanges)
#scinames <- gsub(" ", "_", colnames(fpa1dg[, 3:654]))
colnames(fpa1dg) <- c("Lon", "Lat", newnames)
head(fpa1dg)
dim(fpa1dg)

fpa1dg[1:10, 1:5]

# Match presence-absence data with the phylogeny
fmatched1dg <- match.phylo.comm(phy = fphylo[[1]], comm = fpa1dg[, 3:654])
dim(fmatched1dg$comm)

fcom <- cbind(coords1dg, fmatched1dg$comm)
assemblages <- as.list(paste("Assem", 1:NROW(fcom), sep = "_"))
rownames(fcom) <- rep(assemblages, each = 1)
dim(fcom)
fcom[1:10, 1:10]

##### Save data of the Nodiv preparations #####
save.image("Data/nodivPreparation.RData")
remover <- ls()

# nodiv data
fnodiv1dg <- nodiv_data(phylo = fmatched1dg$phy, commatrix = fcom[, 3:628], 
                        coords = fcom[, 1:2], type = "grid")


fnodiv1dg_uncertainty <- list()
for(i in 1:length(fphylo)){
  svMisc::progress(i, max.value = length(fphylo))
  tr <- fphylo[[i]]
  fnodiv1dg_uncertainty[[i]] <- nodiv_data(phylo = tr, commatrix = fcom[, 3:628], 
                                      coords = fcom[, 1:2], type = "grid")
}

rm(list = remover)

save.image("Data/nodivPreparation_uncertainty.RData")
##### Node divergence analyses #####
# Using the simpler model
frd1dg <- Node_analysis(fnodiv1dg, 10000, "rdtable")
summary(frd1dg)

par(mfrow = c(1, 2))
plot(frd1dg)
plot(fphylo[[1]], show.tip.label = FALSE)
axisPhylo()

par(mfrow = c(3, 2))
plotSOS(frd1dg, 627)
plotSOS(frd1dg, 632)
plotSOS(frd1dg, 635)
plotSOS(frd1dg, 641)
plotSOS(frd1dg, 768)
plotSOS(frd1dg, 912)


# Using a complex model
fqsw1dg <- Node_analysis(fnodiv1dg, 10000, "quasiswap")
summary(fqsw1dg)
plot(fqsw1dg)

##### Save results of node divergence analysis #####
dir.create("Results")

rm(list = remover)
save.image("Results/nodivResults.RData")

