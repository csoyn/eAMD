
1. 두개의 파일을 connection, processsing function 이 있는 위치로 가져가서 진행
2. connection.R의 library 불러오는 부분에 추가 된게 있어 복붙
library(SqlRender)
library(DatabaseConnector)
library(dplyr)
library(sunburstR)
library(gee)
library(tidyr)
library(ztable)
library(moonBook)

3. concept_id 설정해놓은거 그대로 사용

4. for_VA_plot.R 돌릴때 다시 한번 현재 위치 확인
- connection과 processing function 파일 있어야 함 
source("./0_connection.R")
source("./1_processingFunctions.R")
source("./for_VA.R")


