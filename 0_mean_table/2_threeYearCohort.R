
threeYear <- querySql(conn, "select * from g65829.eAMD_TX_3year_csy")
id_all <- read.csv("./id_all.csv")
id_A <- read.csv("./id_A.csv")
id_B <- read.csv("./id_B.csv")
check_table <- matrix(ncol=2, byrow = T)
check_table <- data.frame(check_table)
check_table[1,1] = "Person"
check_table[1,2] = "Row"
check <- checkData(threeYear)
check_table[2,] = c(check["person"], check["row"])

threeYear <- extractFirstDate(threeYear)
threeYear <- threeYear %>%
  mutate(IS_THREEYEAR = ifelse(730<DAY_DIFF & DAY_DIFF<1096, TRUE, FALSE)) %>%
  filter(IS_THREEYEAR)
threeYear = subset(threeYear, select = -c(DRUG_EXPOSURE_END_DATE, FIRST_EXPOSURE_DATE, DAY_DIFF, IS_THREEYEAR))

## id_all
threeYearCohort <- threeYear %>% 
  filter(PERSON_ID %in% id_all$PERSON_ID) 
check <- checkData(threeYearCohort)
check_table[3,] = c(check["person"], check["row"])


# 환자 & 약제 별로 min date(약제 처방 시작 날짜) 설정 -> 약제 변하는 날짜
threeYearCohort <-extractDrugFirstDate(threeYearCohort)

# Drug Concept ID 별로 DRUG_CLASS(string) column 생성
threeYearCohort <- makeDrugClass(threeYearCohort)


### 3. DRUG count 처리
threeYearCohort_a = subset(threeYearCohort, 
                         select = c(PERSON_ID, MIN_DATE, DRUG_CLASS, DRUG_EXPOSURE_START_DATE))

orderedthreeYearCohort_a <- orderExposure(threeYearCohort_a)
orderedthreeYearCohort_a <- makeTotalCount(orderedthreeYearCohort_a) 
orderedthreeYearCohort_a <- makeEachCount(orderedthreeYearCohort_a) 

threeYearCohort_b = orderedthreeYearCohort_a %>%
  select(c(PERSON_ID, MIN_DATE, DRUG_CLASS, DRUG_COUNT, DRUG_TOTAL_COUNT)) %>%
  distinct()
threeYearCohort_b = threeYearCohort_b %>%
  group_by(PERSON_ID, DRUG_CLASS) %>%
  arrange(PERSON_ID,MIN_DATE)

# drug count를 column으로 
threeYearCohort_b = makeEachCountCol(threeYearCohort_b)


### 4. Beva / Rani / Afli / Vert 가 첫번째 주사인 person id table
bevaPeople <- read.csv("./bevaPeople.csv")
raniPeople <- read.csv("./raniPeople.csv")
afliPeople <- read.csv("./afliPeople.csv")
vertPeople <- read.csv("./vertPeople.csv")
nrow(bevaPeople) 
nrow(raniPeople) 
nrow(afliPeople) 
nrow(vertPeople) 


### 5. 각 주사 count를 한 row 로 모음
bevaCount = subset(threeYearCohort_b, select = c(PERSON_ID, BEVA_COUNT), BEVA_COUNT > 0)
raniCount = subset(threeYearCohort_b, select = c(PERSON_ID, RANI_COUNT), RANI_COUNT > 0)
afliCount = subset(threeYearCohort_b, select = c(PERSON_ID, AFLI_COUNT), AFLI_COUNT > 0 )
vertCount = subset(threeYearCohort_b, select = c(PERSON_ID, VERT_COUNT), VERT_COUNT > 0)
allCount = distinct(subset(threeYearCohort_b, select = c(PERSON_ID, DRUG_TOTAL_COUNT)))
countJoin_a = distinct(full_join(bevaCount, raniCount, by='PERSON_ID'))
countJoin_b = distinct(full_join(afliCount, vertCount, by='PERSON_ID'))
countJoin = full_join(countJoin_a, countJoin_b, by='PERSON_ID')
allCountJoin = full_join(countJoin, allCount, by="PERSON_ID")

print("Three Year Cohort Data Processing Finish")
write.csv(check_table, file = "checkTable_three.csv")
print("checkTable_three.csv File Creation Complete")