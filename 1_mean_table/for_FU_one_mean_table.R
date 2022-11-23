# TODO : 2_oneYearCohort.R 에서 변수 변경하기
rm(list = ls())
getwd()
# TODO : 현재 폴더 위치 입력 
path <-""
setwd(path)
source("./0_connection.R")
source("./1_ProcessingFunctions.R")
source("./2_oneYearCohort.R")
source("./3_makeMeanTable_one.R")
dt <- read.table("./FUOneMean.txt", sep=',')
View(dt2)
checkT <- read.table("./checkTable_one.csv", sep=',')
View(checkT)