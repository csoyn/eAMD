rm(list = ls())
getwd()

# TODO : path 맞는지 확인
path <- "./2_Tx_pattern_plot"
setwd(path)
getwd()
source("./0_connection.R")
source("./1_processingFunctions.R")
# get data table
# R / L 구분이 되어있어야 하는 data - Route concept id
eyeData <- querySql(conn, "select * from g65829.eAMD_TX_both_csy")

## TODO : 1_mean_table code돌려서 생성된 파일 사용 - path 확인
id_all = read.csv("../1_mean_table/id_all.csv")
id_A = read.csv("../1_mean_table/id_A.csv")
id_B = read.csv("../1_mean_table/id_B.csv")

# 처방순서매김 PERSON_DRUG_ASD_NUMBER 컬럼 생성
eyeData <- orderExposure(eyeData)

eyeData <- eyeData %>% 
  filter(PERSON_ID %in% id_all$PERSON_ID) %>%
  select(-c( DRUG_EXPOSURE_END_DATE))

check_table <- matrix(ncol=2, byrow = T)
check_table <- data.frame(check_table)
check_table[1,1] = "Person"
check_table[1,2] = "Row"
check <- checkData(eyeData) 
check_table[2,] = c(check["person"], check["row"])
eyeData$DRUG_EXPOSURE_START_DATE = as.Date(eyeData$DRUG_EXPOSURE_START_DATE)

# TODO : drug 확인 - 4가지가 있어야 함.
table(eyeData$DRUG_CONCEPT_ID)

eyeData <- eyeData %>%
  mutate(ROUTE_CLASS = 
           ifelse(ROUTE_CONCEPT_ID %in% right, "Right",
                  ifelse(ROUTE_CONCEPT_ID %in% left, "Left",
                         ifelse(ROUTE_CONCEPT_ID %in% bi, "Bi",
                                ifelse(ROUTE_CONCEPT_ID %in% intra_ocular, "Intra-ocular",
                                       ifelse(ROUTE_CONCEPT_ID %in% intra_venous, "Intra-venous",
                                              ifelse(ROUTE_CONCEPT_ID == intra_vitreal, "Intra-vitreal", "Others")))))))

################################### Verteporfin ####################################

# TODO : Verteporfin처방이 Right, Left를 가지고 있는지 확인.
# Verteporfin일 경우 Right, Left정보가 없을 수도 있음
verteporfin <- eyeData %>%
  filter(DRUG_CONCEPT_ID %in% drug_vert)
table(verteporfin$ROUTE_CLASS)

### 1.Right, Left가 없을 경우  - 아래 code 3줄 실행 후 2번으로 
#replace ROUTE_CLASS
replacedVert <- leftOrRight(eyeData, verteporfin)
eyeDatanotVert <- eyeData %>% filter(! DRUG_CONCEPT_ID %in% drug_vert)
eyeData <- rbind(eyeDatanotVert, replacedVert)
################################ Verteporfin End ###################################

table(eyeData$ROUTE_CLASS)
### 2. Right, Left가 있을 경우 - 바로 여기로 넘어오면 됌.
routeArr <- c("Left", "Right", "Bi")
eyeData <- eyeData %>%
  filter(ROUTE_CLASS %in% routeArr)

# 환자 -> R or L -> Drug별로 첫 처방 구하기
eyeData_ordered <- eyeData %>%
  group_by(PERSON_ID, ROUTE_CLASS, DRUG_CONCEPT_ID) %>%
  arrange(DRUG_EXPOSURE_START_DATE) %>%
  mutate(DRUG_ORDER = row_number()) %>%
  filter(DRUG_ORDER == 1)

# 4가지가 다 나오는지 확인
table(eyeData_ordered$DRUG_CONCEPT_ID)

eyeData_RL <- eyeData_ordered %>%
  filter(ROUTE_CLASS == "Right" | ROUTE_CLASS == "Left")

# Bi일 경우 pathway가 R로 한번, L로 한 번 2번으로 나뉘어야 함.
eyeData_Bi <- eyeData_ordered %>%
  filter(ROUTE_CLASS == "Bi")
# Bi row x 2
# right로 한 번
BitoRight <- eyeData_Bi %>%
  filter(ROUTE_CLASS == "Bi")
BitoRight$ROUTE_CLASS = "Right_Bi"

# left로 한 번
BitoLeft <- eyeData_Bi %>%
  filter(ROUTE_CLASS == "Bi")
BitoLeft$ROUTE_CLASS = "Left_Bi"

# 합치기

eyeData_final <- rbind(eyeData_RL, BitoRight, BitoLeft)
eyeData_final <- makeDrugClass(eyeData_final)

eyeData_final <- eyeData_final %>%
  mutate(ROUTE_CLASS = replace(ROUTE_CLASS, ROUTE_CLASS=="Left_Bi", "Left"))
eyeData_final <- eyeData_final %>%
  mutate(ROUTE_CLASS = replace(ROUTE_CLASS, ROUTE_CLASS=="Right_Bi", "Right"))

eyeData_final <- data.frame(eyeData_final %>%
                              group_by(PERSON_ID, ROUTE_CLASS) %>%
                              mutate(TxPathway = paste(DRUG_CLASS, collapse = '-')))

eyeData_for_plot <- eyeData_final %>% select('PERSON_ID', 'TxPathway', "ROUTE_CLASS") %>% distinct()
eyeData_for_plot <- eyeData_for_plot %>%
  mutate(PERIOD = ifelse(PERSON_ID %in% id_A$PERSON_ID, "A",
                       ifelse(PERSON_ID %in% id_B$PERSON_ID, "B", "OTHER")))
check <- checkData(eyeData_for_plot) 
check_table[3,] = c(check["person"], check["row"])

eyeData_for_plot <- eyeData_for_plot %>%
  select(-c(PERSON_ID))
write.csv(eyeData_for_plot, file = "eyeData_for_plot.csv")
write.csv(check_table, file = "check_table_for_plot.csv")
print("success save files")






























