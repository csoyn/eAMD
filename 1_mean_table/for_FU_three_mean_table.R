# TODO : 2_threeYearCohort.R 에서 변수 변경하기
rm(list = ls())
getwd()
# TODO : 현재 폴더 위치 입력 
path <-""
setwd(path)
source("./0_connection.R")
source("./1_ProcessingFunctions.R")
source("./2_threeYearCohort.R")
source("./3_makeMeanTable_three.R")

dt <- read.table("./FUThreeMean.txt", sep=',')
View(dt)
checkT <- read.table("./checkTable_three.csv", sep=',')
View(checkT)
