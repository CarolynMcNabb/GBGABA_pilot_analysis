#CMcNabb 2021
#data setup for GLM for dti analysis
setwd("/Volumes/GoogleDrive/My Drive/Pilot")
library("Jmisc")
library(dplyr)

#read in demographic, Autism quotient and gut diversity data
pilot_raw <- read.csv("pilot_bacteria_mrs_lcms_GenusLevel.csv")
diversity <- pilot_raw[c("age","hand","faith_pd","shannon","observed_otus", "aq")]

#recode handedness from right and left to 0s and 1s
diversity$hand <- recode(diversity$hand, Right = 0, Left = 1)

#create dataframes for GLM, including diversity measures/Autism quotient, age, handedness and motion, then demean these values for use in FSL's randomise
shannon_GLM <- demean(cbind(diversity$shannon, diversity$age, diversity$hand))
otus_GLM <- demean(cbind(diversity$observed_otus, diversity$age, diversity$hand))
faith_GLM <- demean(cbind(diversity$faith_pd, diversity$age, diversity$hand))
aq_GLM <- demean(cbind(diversity$aq, diversity$age, diversity$hand))

# write GLMs to csv format
write.table( shannon_GLM, "GBGABA_GLMshannon.csv", sep=",", col.names=FALSE, row.names = FALSE)
write.table( otus_GLM, "GBGABA_GLMotus.csv", sep=",", col.names=FALSE, row.names = FALSE)
write.table( faith_GLM, "GBGABA_GLMfaith.csv", sep=",", col.names=FALSE, row.names = FALSE)
write.table( aq_GLM, "GBGABA_GLMaq.csv", sep=",", col.names=FALSE, row.names = FALSE)
