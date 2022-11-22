rm(list = ls())
getwd()
path <-"E:/Users/DPSJ001/Documents/CSY/R_eAMD_0726/0726/final_codes"
setwd(path)
source("./0_connection.R")
source("./1_ProcessingFunctions.R")
source("./2_threeYearCohort.R")
source("./3_makeMeanTable_three.R")

dt <- read.table("./FUThreeMean.txt", sep=',')
View(dt)
checkT <- read.table("./checkTable_three.csv", sep=',')
View(checkT)
