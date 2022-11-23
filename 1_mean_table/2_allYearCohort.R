# TODO : data table 명
# get data table
obserAll <- querySql(conn, "select * from g65829.eAMD_TX_allyear_csy")
# number of person, number of row table
check_table <- matrix(ncol=2, byrow = T)
check_table <- data.frame(check_table)
check_table[1,1] = "Person"
check_table[1,2] = "Row"
# row 개수 확인
check <- checkData(obserAll)
check_table[2,] = c(check["person"], check["row"])
### 0. person별로 DRUG_EXPOSURE_START_DATE 오름차순으로 순위 부여 -> 순위가 1인게 Index date
orderedData <- orderExposure(obserAll)

### 1. OBSERVATION All 기간 나누기  - 계속 쓰임
# (1) 08년도 ~ 19년도 전체 기간 person_id 
id_all <- extractID(orderedData, "all")
# (2) 08년도 ~ 12년도 : Period A person_id table
id_A <- extractID(orderedData, "A")
# (3) 13년도 ~ 18년도 : Period B person_id table
id_B <- extractID(orderedData, "B") 
check_table[3,1] = nrow(id_all)
check_table[4,1] = nrow(id_A)
check_table[5,1] = nrow(id_B)
write.csv(id_all, "./id_all.csv")
write.csv(id_A, "./id_A.csv")
write.csv(id_B, "./id_B.csv")

print("id_all, id_A, id_B File Creation Complete")

### 2. 08년도 ~ 19년도 Data 

allYearCohort <- orderedData %>% 
  filter(PERSON_ID %in% id_all$PERSON_ID) 
check <- checkData(allYearCohort)
check_table[6,] = c(check["person"], check["row"])
View(check_table)
## Date column
allYearCohort$DRUG_EXPOSURE_START_DATE = as.Date(allYearCohort$DRUG_EXPOSURE_START_DATE)

# 환자 & 약제 별로 min date(약제 처방 시작 날짜) -> 약제 변하는 날짜
allYearCohort <- extractDrugFirstDate(allYearCohort)

# Drug Concept ID 별로 DRUG_CLASS(string) column 생성
allYearCohort <- makeDrugClass(allYearCohort)

### 3. DRUG count 처리
allYearCohort_a = subset(allYearCohort, 
                         select = c(PERSON_ID, MIN_DATE, DRUG_CLASS, PERSON_DRUG_ASD_NUMBER))

allYearCohort_a = makeTotalCount(allYearCohort_a)

allYearCohort_a = makeEachCount(allYearCohort_a)

# count만 남긴 table
allYearCohort_b = allYearCohort_a %>%
  select(c(PERSON_ID, MIN_DATE, DRUG_CLASS, DRUG_COUNT, DRUG_TOTAL_COUNT)) %>%
  distinct()

allYearCohort_b = allYearCohort_b %>%
  group_by(PERSON_ID, DRUG_CLASS) %>%
  arrange(PERSON_ID,MIN_DATE)

# drug 별 count를 입력 
allYearCohort_b <-makeEachCountCol(allYearCohort_b)


### 4. Beva / Rani / Afli / Vert 가 첫번째 주사인 person id table
bevaPeople <- firstDrugID(allYearCohort, "Bevacizumab")
nrow(bevaPeople)
raniPeople = firstDrugID(allYearCohort, "Ranibizumab")
nrow(raniPeople) # 636
afliPeople = firstDrugID(allYearCohort, "Aflibercept")
nrow(afliPeople) # 345
vertPeople = firstDrugID(allYearCohort, "Verteporfin")
nrow(vertPeople) # 6

write.csv(bevaPeople, "./bevaPeople.csv")
write.csv(raniPeople, "./raniPeople.csv")
write.csv(afliPeople, "./afliPeople.csv")
write.csv(vertPeople, "./vertPeople.csv")

print("bevaPeople, raniPeople, afliPeople, vertPeople File Creation Complete")

### 3. 각 주사 count를 한 row 로 모음
bevaCount = subset(allYearCohort_b, select = c(PERSON_ID, BEVA_COUNT), BEVA_COUNT > 0)
raniCount = subset(allYearCohort_b, select = c(PERSON_ID, RANI_COUNT), RANI_COUNT > 0)
afliCount = subset(allYearCohort_b, select = c(PERSON_ID, AFLI_COUNT), AFLI_COUNT > 0 )
vertCount = subset(allYearCohort_b, select = c(PERSON_ID, VERT_COUNT), VERT_COUNT > 0)
allCount = distinct(subset(allYearCohort_b, select = c(PERSON_ID, DRUG_TOTAL_COUNT)))
countJoin_a = distinct(full_join(bevaCount, raniCount, by='PERSON_ID'))
countJoin_b = distinct(full_join(afliCount, vertCount, by='PERSON_ID'))
countJoin = full_join(countJoin_a, countJoin_b, by='PERSON_ID')
allCountJoin = full_join(countJoin, allCount, by="PERSON_ID")

print("Cohort Data Processing Finish")
write.csv(check_table, file = "checkTable_all.csv")
print("all_checkTable.csv File Creation Complete")
