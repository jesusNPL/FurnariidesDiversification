
rm(list = ls())

library(geiger)
library(qpcR)

## Extract results
## Time-dependent models - Morlon models
load("./Results/furna_divTime_500trees_complete_results_Morlon.Rdata")
morlon <- final_table_tree_file
weight_morlon <- aicw(morlon$means$AICc)

morlon_total <- cbind(morlon$means, weight_morlon, morlon$std.err)
write.csv(morlon_total, "table_morlon_total.csv")

# Constant models = yule and bd
yule_bd_means <- morlon$means[1:2,]
yule_bd_sd <- morlon$std.err[1:2,]

yule_bd_weights <- aicw(yule_bd_means$AICc)

yule_bd_final <- cbind(yule_bd_means, yule_bd_weights, yule_bd_sd)
write.csv(yule_bd_final, "table_yule_bd.csv")

# Only linear dependence models
morlon_linear <- morlon$means[7:10,]

morlon_linear_weights <- aicw(morlon_linear$AICc)

morlon_linear_final <- cbind(morlon_linear, morlon_linear_weights, morlon$std.err[7:10,])
write.csv(morlon_linear_final, "table_morlon_linear.csv")

## Environmental models - Condamine models
load("./Results/furna_divTime_500trees_complete_results_PastTemperature.Rdata")
Tempe <- final_table_tree_file
load("./Results/furna_divTime_500trees_complete_results_PastAndeanAltitude.Rdata")
Alti <- final_table_tree_file
load("./Results/furna_divTime_500trees_complete_results_PastSeaLevel.Rdata")
Seas <- final_table_tree_file

weight_tempe <- aicw(Tempe$means$AICc)
weight_alti <- aicw(Alti$means$AICc)
weight_seas <- aicw(Seas$means$AICc)

tempe_total <- cbind(Tempe$means, weight_tempe, Tempe$std.err)
write.csv(tempe_total, "table_temperature_total.csv")

alti_total <- cbind(Alti$means, weight_alti, Alti$std.err)
write.csv(alti_total, "table_altitude_total.csv")

seas_total <- cbind(Seas$means, weight_seas, Seas$std.err)
write.csv(seas_total, "table_seas_total.csv")

## Linear paleoenvironmental-models
# Temperature
tempe_linear <- Tempe$means[5:8,]
tempe_linear_weigths <- aicw(tempe_linear$AICc)
tempe_linear_final <- cbind(tempe_linear, tempe_linear_weigths, Tempe$std.err[5:8,])
write.csv(tempe_linear_final, "table_temperature_linear.csv")

# Altitude
alti_linear <- Alti$means[5:8,]
alti_linear_weigths <- aicw(alti_linear$AICc)
alti_linear_final <- cbind(alti_linear, alti_linear_weigths, Alti$std.err[5:8,])
write.csv(alti_linear_final, "table_altitude_linear.csv")

# Sea level
seas_linear <- Seas$means[5:8,]
seas_linear_weigths <- aicw(seas_linear$AICc)
seas_linear_final <- cbind(seas_linear, seas_linear_weigths, Seas$std.err[5:8,])
write.csv(seas_linear_final, "table_seas_linear.csv")
