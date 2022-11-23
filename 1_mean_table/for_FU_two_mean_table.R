rm(list = ls())
getwd()
path <-"E:/Users/DPSJ001/Documents/CSY/R_eAMD_0726/0726/final_codes"
setwd(path)
source("./0_connection.R")
source("./1_ProcessingFunctions.R")
source("./2_twoYearCohort.R")
source("./3_makeMeanTable_two.R")

dt <- read.table("./FUTwoMean.txt", sep=',')
View(dt)
checkT <- read.table("./checkTable_two.csv", sep=',')
View(checkT)