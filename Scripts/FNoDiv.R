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



fcomm <- read.csv("Table_S2.csv", row.names = 1)
dim(fcomm)

head(fcomm[, 1:2])
ftree <- read.nexus("furna_divTime_WO_MCC_newNames.nex")

forest <- readOGR(file.choose(), "Fores_habitats")
open <- readOGR(file.choose(), "Open_habitats")
habitats <- rbind(forest, open)
plot(habitats)

matched2 <- match.phylo.comm(phy = ftree, comm = fcomm[, 6:589])
dim(matched2$comm)

fdata <- nodiv_data(phylo = matched2$phy, commatrix = matched2$comm, coords = fcomm[, 1:2], 
                    type = "points", shape = habitats)

frd <- Node_analysis(fdata, 10000, "rdtable")
summary(frd)
plot(frd)

par(mfrow = c(2, 2))
plotSOS(frd, 261, match.ID = FALSE)
plotSOS(frd, 266, match.ID = FALSE)
plotSOS(frd, 269, match.ID = FALSE)
plotSOS(frd, 433, match.ID = FALSE)

fqsw <- Node_analysis(fdata, 10000, "quasiswap")
summary(fqsw)
plot(fqsw)

par(mfrow = c(2, 3))
plotSOS(fqsw, 261)
plotSOS(fqsw, 266)
plotSOS(fqsw, 267)
plotSOS(fqsw, 269)
plotSOS(fqsw, 327)
plotSOS(fqsw, 373)

save.image("FurnariideNODIV.RData")


fqsw[[2]]
pAbund <- fqsw[[8]]

fnodes <- c(261, 266, 267, 269, 327, 373) 
fqswNodes <- data.frame(fqsw[[12]])

fqswGND <- fqsw[[13]]
fqswGND


hist(na.omit(fqswGND))
abline(v = mean(na.omit(fqswGND)), col = "black", lwd = 3)
abline(v = 0.7, col = "red", lwd = 3)

fSOS261 <- fqswNodes$X261
fSOS266 <- fqswNodes$X266
fSOS267 <- fqswNodes$X267
fSOS269 <- fqswNodes$X269
fSOS327 <- fqswNodes$X327
fSOS373 <- fqswNodes$X373

fSOSnodes <- cbind(fcomm[, 1:2], fSOS261, fSOS266, fSOS267, fSOS269, fSOS327, fSOS373, 
                   fcomm$Country, fcomm$Habitat, fcomm$Richness)

ForestSOS <- fSOSnodes[which(fSOSnodes$`fcomm$Habitat` == "Forest"), ]
OpenSOS <- fSOSnodes[which(fSOSnodes$`fcomm$Habitat` == "Open"), ]

hist(fSOSnodes$fSOS261)
hist(ForestSOS$fSOS261, add = T, col = "green")
hist(OpenSOS$fSOS261, add = T, col = "yellow")


require(scales)

pdf(file = "HistNodes.pdf", width = 10, height = 10)
par(mfrow = c(2, 3))
#par(mar = c(2, 2, 2, 4), xpd = T)
par(oma = c(5, 1, 3, 2))
par(mar = c(5, 5, 4, 2))
#par(cex = 1)
par(cex.axis = 2)
par(cex.lab = 2)
par(cex.main = 2)
# Node 261
hist(fSOSnodes$fSOS261, col = scales::alpha("black", 0.2), main = "Node 261", xlab = NA, xlim = c(-5, 5.5))
hist(ForestSOS$fSOS261, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS261, add = T, col = scales::alpha("khaki", 0.7))
# Node 266
hist(fSOSnodes$fSOS266, col = scales::alpha("black", 0.2), main = "Node 266", xlab = NA, xlim = c(-5, 5.5))
hist(ForestSOS$fSOS266, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS266, add = T, col = scales::alpha("khaki", 0.7))
# Node 267
hist(fSOSnodes$fSOS267, col = scales::alpha("black", 0.2), main = "Node 267", xlab = NA, xlim = c(-6, 4))
hist(ForestSOS$fSOS267, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS267, add = T, col = scales::alpha("khaki", 0.7))
# Node 269
hist(fSOSnodes$fSOS269, col = scales::alpha("black", 0.2), main = "Node 269", xlab = "SOS values", xlim = c(-7.5, 4))
hist(ForestSOS$fSOS269, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS269, add = T, col = scales::alpha("khaki", 0.7))
# Node 327
hist(fSOSnodes$fSOS327, col = scales::alpha("black", 0.2), main = "Node 327", xlab = "SOS values", xlim = c(-3.5, 3.5))
hist(ForestSOS$fSOS327, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS327, add = T, col = scales::alpha("khaki", 0.7))
# Node 373
hist(fSOSnodes$fSOS373, col = scales::alpha("black", 0.2), main = "Node 373", xlab = "SOS values", xlim = c(-2.5, 3.5))
hist(ForestSOS$fSOS373, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS373, add = T, col = scales::alpha("khaki", 0.7))

dev.off()



pdf(file = "HistNodesFinal.pdf", width = 10, height = 10)
par(mfrow = c(2, 2))
# Phylogeny
plot(fqsw, lwd = 1, col = mypalette)
# Node 261
hist(fSOSnodes$fSOS261, col = scales::alpha("black", 0.2), main = "Node 261", xlab = "SOS values", xlim = c(-5, 6))
hist(ForestSOS$fSOS261, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS261, add = T, col = scales::alpha("khaki", 0.7))
# Node 266
hist(fSOSnodes$fSOS266, col = scales::alpha("black", 0.2), main = "Node 266", xlab = "SOS values", xlim = c(-5, 6))
hist(ForestSOS$fSOS266, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS266, add = T, col = scales::alpha("khaki", 0.7))
# Node 269
hist(fSOSnodes$fSOS269, col = scales::alpha("black", 0.2), main = "Node 269", xlab = "SOS values", xlim = c(-8, 4))
hist(ForestSOS$fSOS269, add = T, col = scales::alpha("palegreen4", 0.7))
hist(OpenSOS$fSOS269, add = T, col = scales::alpha("khaki", 0.7))
legend("topleft", c("All", "Forest", "Open"), fill = c("gray", "palegreen4", "khaki"), box.lty = 0, bg = NA)

dev.off()



#### Prepare multi map of nodesig #####
library(tmap)
tm_shape(forest) + tm_fill(col = "palegreen4", legend.show = F, alpha = 0.9) +
  tm_shape(open) + tm_fill(col = "khaki", legend.show = F, alpha = 0.7) +
  tm_shape(sosPoints) + tm_bubbles(col = "Node261", palette = "Reds", style = "quantile", 
                                   legend.size.show = FALSE, size = 0.15) + 
  tm_layout(legend.position = c("right", "bottom"), legend.text.size = 0.7, legend.title.size = 1, frame = FALSE)


pdf(file = "Phylo_Maps_NodesFinal.pdf", width = 10, height = 10)
par(mfrow = c(2, 2))
# Phylogeny
plot(fqsw)
# Node 261
t1 <- tm_shape(forest) + tm_fill(col = "palegreen4", legend.show = F, alpha = 0.9) +
  tm_shape(open) + tm_fill(col = "khaki", legend.show = F, alpha = 0.7) +
  tm_shape(sosPoints) + tm_bubbles(col = "Node261", palette = "Reds", style = "quantile", 
                                   legend.size.show = FALSE, size = 0.15) + 
  tm_layout(legend.position = c("right", "bottom"), legend.text.size = 0.7, legend.title.size = 1, frame = FALSE)
# Node 266
t2 <- tm_shape(forest) + tm_fill(col = "palegreen4", legend.show = F, alpha = 0.9) +
  tm_shape(open) + tm_fill(col = "khaki", legend.show = F, alpha = 0.7) +
  tm_shape(sosPoints) + tm_bubbles(col = "Node266", palette = "Reds", style = "quantile", 
                                   legend.size.show = FALSE, size = 0.15) + 
  tm_layout(legend.position = c("right", "bottom"), legend.text.size = 0.7, legend.title.size = 1, frame = FALSE)
# Node 269
t3 <- tm_shape(forest) + tm_fill(col = "palegreen4", legend.show = F, alpha = 0.9) +
  tm_shape(open) + tm_fill(col = "khaki", legend.show = F, alpha = 0.7) +
  tm_shape(sosPoints) + tm_bubbles(col = "Node269", palette = "Reds", style = "quantile", 
                                   legend.size.show = FALSE, size = 0.15) + 
  tm_layout(legend.position = c("right", "bottom"), legend.text.size = 0.7, legend.title.size = 1, frame = FALSE)


dev.off()

library(RColorBrewer)
colfunc <- colorRampPalette(c("white", "red4"))
mypalette <- brewer.pal(7, "Reds")


pdf(file = "Phylo_NodesFinal.pdf", width = 10, height = 8)
plot(fqsw, lwd = 1, col = mypalette)
#plot(fqsw, lwd = 1, col = colfunc(50))
dev.off()

pdf(file = "Phylo_Maps_NodesFinal.pdf", width = 15, height = 10)
tmap_arrange(t1, t2, t3)
dev.off()
