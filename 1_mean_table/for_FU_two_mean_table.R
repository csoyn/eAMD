# TODO : 2_twoYearCohort.R 에서 변수 변경하기
rm(list = ls())
getwd()
# TODO : 현재 폴더 위치 입력 
path <-"E:/Users/DPSJ001/Documents/CSY/R_eAMD_0726/0726/final_codes"
setwd(path)
source("./0_connection.R")
source("./1_processingFunctions.R")
source("./2_twoYearCohort.R")
source("./3_makeMeanTable_two.R")

dt <- read.table("./FUTwoMean.txt", sep=',')
View(dt)
checkT <- read.table("./checkTable_two.csv", sep=',')
View(checkT)
