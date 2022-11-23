# TODO : 0_connection.R, 2_allYearCohort.R 에서 변수 변경하기

rm(list = ls())
getwd()
# TODO : 현재 폴더 위치 입력 
path <-""
setwd(path)
source("./0_connection.R")
source("./1_ProcessingFunctions.R")
source("./2_allYearCohort.R")
source("./3_makeMeanTable_all.R")
dt <- read.table("./FUAllMean.txt", sep=',')
View(dt)
