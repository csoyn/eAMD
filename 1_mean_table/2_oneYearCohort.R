
# TODO : data table 명
oneYear<- querySql(conn, "select * from g65829.eAMD_TX_1year_csy")
check_table <- matrix(ncol=2, byrow = T)
check_table <- data.frame(check_table)
check_table[1,1] = "Person"
check_table[1,2] = "Row"
check <- checkData(oneYear)
check_table[2,] = c(check["person"], check["row"])
# 처방순서매김 PERSON_DRUG_ASD_NUMBER -> row_number
oneYear <- orderExposure(oneYear)
oneYear$DRUG_EXPOSURE_START_DATE = as.Date(oneYear$DRUG_EXPOSURE_START_DATE)
# DAY-DIff만들기 -> DRUG_EXPOSURE_START_DATE - FIRST_EXPOSURE_DATE
oneYear <- extractFirstDate(oneYear)
oneYear <- oneYear %>%
  mutate(IS_ONEYEAR = ifelse(DAY_DIFF<366, TRUE, FALSE)) %>%
  filter(IS_ONEYEAR)
oneYear = subset(oneYear, select = -c(DRUG_EXPOSURE_END_DATE, FIRST_EXPOSURE_DATE, IS_ONEYEAR))

## 1. 기간 personid 나누기
# (1) 08년도 ~ 19년도 전체 기간 person_id 
id_all <- extractID(oneYear, "all")
# (2) 08년도 ~ 12년도 : Period A person_id table
id_A <- extractID(oneYear, "A")
# (3) 13년도 ~ 18년도 : Period B person_id table
id_B <- extractID(oneYear, "B") 


## all column
oneYearCohort <- oneYear %>% 
  filter(PERSON_ID %in% id_all$PERSON_ID) 
check <- checkData(oneYearCohort)
check_table[3,] = c(check["person"], check["row"])

# 환자 & 약제 별로 min date(약제 처방 시작 날짜) 설정 -> 약제 변하는 날짜

oneYearCohort <- extractDrugFirstDate(oneYearCohort)
# Drug Concept ID 별로 DRUG_CLASS(string) column 생성
oneYearCohort <- makeDrugClass(oneYearCohort)

### 3. DRUG count 처리
oneYearCohort_a = subset(oneYearCohort, 
                         select = c(PERSON_ID, MIN_DATE, DRUG_CLASS, PERSON_DRUG_ASD_NUMBER))

# 환자별 drug 총 conut
oneYearCohort_a = makeTotalCount(oneYearCohort_a)
  
# 환자별, drug 별 count
oneYearCohort_a = makeEachCount(oneYearCohort_a)

# count만 남김
oneYearCohort_b = oneYearCohort_a %>%
  select(c(PERSON_ID, MIN_DATE, DRUG_CLASS, DRUG_COUNT, DRUG_TOTAL_COUNT, PERSON_DRUG_ASD_NUMBER )) %>%
  distinct()

oneYearCohort_b = oneYearCohort_b %>%
  group_by(PERSON_ID, DRUG_CLASS) %>%
  arrange(PERSON_ID,MIN_DATE)

# drug count를 column으로 
oneYearCohort_b = makeEachCountCol(oneYearCohort_b)

### 4. Beva / Rani / Afli / Vert 가 첫번째 주사인 person id table
bevaPeople <- firstDrugID(oneYearCohort_b, "Bevacizumab")
nrow(bevaPeople) # 157
raniPeople = firstDrugID(oneYearCohort_b, "Ranibizumab")
nrow(raniPeople) # 551
afliPeople = firstDrugID(oneYearCohort_b, "Aflibercept")
nrow(afliPeople) # 251
vertPeople = firstDrugID(oneYearCohort_b, "Verteporfin")
nrow(vertPeople) # 5


### 5. 각 주사 count를 한 row 로 모음
bevaCount = subset(oneYearCohort_b, select = c(PERSON_ID, BEVA_COUNT), BEVA_COUNT > 0)
raniCount = subset(oneYearCohort_b, select = c(PERSON_ID, RANI_COUNT), RANI_COUNT > 0)
afliCount = subset(oneYearCohort_b, select = c(PERSON_ID, AFLI_COUNT), AFLI_COUNT > 0 )
vertCount = subset(oneYearCohort_b, select = c(PERSON_ID, VERT_COUNT), VERT_COUNT > 0)
allCount = distinct(subset(oneYearCohort_b, select = c(PERSON_ID, DRUG_TOTAL_COUNT)))
countJoin_a = distinct(full_join(bevaCount, raniCount, by='PERSON_ID'))
countJoin_b = distinct(full_join(afliCount, vertCount, by='PERSON_ID'))
countJoin = full_join(countJoin_a, countJoin_b, by='PERSON_ID')
allCountJoin = full_join(countJoin, allCount, by="PERSON_ID")

print("One Year Cohort Data Processing Finish")
write.csv(check_table, file = "checkTable_one.csv")
print("checkTable_one.csv File Creation Complete")
