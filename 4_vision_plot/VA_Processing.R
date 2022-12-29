source("./0_connection.R")
source("./1_processingFunctions.R")

# 아주대 
rightIds <-c("2000000436", "2000000438")
leftIds <- c("2000000437", "2000000439")

# TODO - table 위치
sightData <- querySql(conn, "select * from g65829.eamd_va_index_gp_csy2")
drugData <- querySql(conn, "select * from g65829.eamd_TX_both_csy")
sightData <- sightData %>%
  select(-c(MEASUREMENT_SOURCE_VALUE, DIFF)) %>%
  filter(DIFF_GP !=9999) %>%
  filter(! is.na(VALUE_AS_NUMBER)) %>%
  distinct()

sightData$MEASUREMENT_CONCEPT_ID = as.character(sightData$MEASUREMENT_CONCEPT_ID)
sightData$VALUE_AS_NUMBER = as.numeric(sightData$VALUE_AS_NUMBER)

sightData <- sightData %>%
  mutate(VA_CLASS = ifelse(MEASUREMENT_CONCEPT_ID %in% rightIds, "Right",
      ifelse(MEASUREMENT_CONCEPT_ID %in% leftIds, "Left", "Others"))) %>%
  select(-c(ROUTE_CONCEPT_ID, VALUE_SOURCE_VALUE, MEASUREMENT_DATE))

# TODO : 파일 위치 확인 
id_all = read.csv("../1_mean_table/id_all.csv")
arr <- c("Right", "Left")

drugData <- orderExposure(drugData)
drugData <- drugData %>%
  filter(PERSON_DRUG_ASD_NUMBER ==1) %>%
  select(PERSON_ID, DRUG_EXPOSURE_START_DATE, ROUTE_CONCEPT_ID, DRUG_CONCEPT_ID)

drugData <- drugData %>% 
  mutate(ROUTE_CLASS =
      ifelse(ROUTE_CONCEPT_ID %in% right, "Right",
        ifelse(ROUTE_CONCEPT_ID %in% left, "Left", "Others")))

drugData <- makeDrugClass(drugData)

drugData <- drugData %>%
  filter(ROUTE_CLASS =="Right" | ROUTE_CLASS =="Left") %>%
  select(PERSON_ID, DRUG_EXPOSURE_START_DATE, ROUTE_CLASS, DRUG_CLASS)

drugData_ini <- subset(drugData, select=c(PERSON_ID, DRUG_CLASS, ROUTE_CLASS))

drugData <- drugData %>%
  select(c(PERSON_ID, ROUTE_CLASS)) %>% distinct()
drugData <- rename(drugData, "VA_CLASS" = "ROUTE_CLASS")



# Index date data
sightData_Index <- sightData %>%
  filter(DIFF_GP ==0) %>%
  filter(PERSON_ID %in% drugData$PERSON_ID) %>%
  group_by(PERSON_ID, VA_CLASS) %>%
  mutate(MAX_VALUE = max(VALUE_AS_NUMBER)) %>%
  select(-c(VALUE_AS_NUMBER, MEASUREMENT_CONCEPT_ID)) %>% distinct()

indexData <- inner_join(sightData_Index, drugData, by=c("PERSON_ID", "VA_CLASS")) %>% distinct()

check_table <- matrix(ncol=2, byrow = T)
check_table <- data.frame(check_table)
check_table[1,1] = "Person"
check_table[1,2] = "Row"
check <- checkData(indexData) 
check_table[2,] = c(check["person"], check["row"])

indexData$logmar <- round(log10(1/indexData$MAX_VALUE), 2)

# Index +90일 data
sightData_after90 <- sightData %>%
  filter(DIFF_GP == 90) %>%
  filter(PERSON_ID %in% drugData$PERSON_ID) %>%
  group_by(PERSON_ID, VA_CLASS) %>%
  mutate(MAX_VALUE = max(VALUE_AS_NUMBER)) %>%
  select(-c(VALUE_AS_NUMBER, MEASUREMENT_CONCEPT_ID)) %>% distinct()

after90Data <- inner_join(sightData_after90, drugData, by=c("PERSON_ID", "VA_CLASS")) %>% distinct()

check <- checkData(after90Data) 
check_table[3,] = c(check["person"], check["row"])

after90Data$logmar <- round(log10(1/after90Data$MAX_VALUE), 2)


# Index +365일 data
sightData_after365 <- sightData %>%
  filter(DIFF_GP == 365) %>%
  filter(PERSON_ID %in% drugData$PERSON_ID) %>%
  group_by(PERSON_ID, VA_CLASS) %>%
  mutate(MAX_VALUE = max(VALUE_AS_NUMBER)) %>%
  select(-c(VALUE_AS_NUMBER, MEASUREMENT_CONCEPT_ID)) %>% distinct()

after365Data <- inner_join(sightData_after365, drugData, by=c("PERSON_ID", "VA_CLASS")) %>% distinct()

check <- checkData(after365Data) 
check_table[4,] = c(check["person"], check["row"])

after365Data$logmar <- round(log10(1/after365Data$MAX_VALUE), 2)


# Index +730일 data
sightData_after730 <- sightData %>%
  filter(DIFF_GP == 730) %>%
  filter(PERSON_ID %in% drugData$PERSON_ID) %>%
  group_by(PERSON_ID, VA_CLASS) %>%
  mutate(MAX_VALUE = max(VALUE_AS_NUMBER)) %>%
  select(-c(VALUE_AS_NUMBER, MEASUREMENT_CONCEPT_ID)) %>% distinct()

after730Data <- inner_join(sightData_after730, drugData, by=c("PERSON_ID", "VA_CLASS")) %>% distinct()

check <- checkData(after730Data) 
check_table[5,] = c(check["person"], check["row"])

after730Data$logmar <- round(log10(1/after730Data$MAX_VALUE), 2)

# merge 
dt_index <- indexData %>% ungroup(VA_CLASS) %>% select(PERSON_ID, logmar)
dt_90 <- after90Data %>% ungroup(VA_CLASS) %>% select(PERSON_ID, logmar)
dt_365 <- after365Data %>% ungroup(VA_CLASS) %>% select(PERSON_ID, logmar)
dt_730 <- after730Data %>% ungroup(VA_CLASS) %>% select(PERSON_ID, logmar)

dt_merge <- merge(merge(merge(
  dt_index, dt_90, by = "PERSON_ID", all=TRUE),
  dt_365, by = "PERSON_ID", all=TRUE),
  dt_730, by = "PERSON_ID", all=TRUE)
colnames(dt_merge) <- c("SUBJECT_ID", "DAY0", "DAY90", "DAY365", "DAY730")

dt_long <- gather(dt_merge, DAY, LOGMAR, DAY0:DAY730, factor_key = TRUE)

dt_long$DAY_NUM <- ifelse(dt_long$DAY =="DAY90", 90,
  ifelse(dt_long$DAY =="DAY365", 365,
    ifelse(dt_long$DAY =="DAY730", 730, 0)))

dt_long$TIME <- ifelse(dt_long$DAY =="DAY90", 2,
  ifelse(dt_long$DAY =="DAY365", 3,
    ifelse(dt_long$DAY =="DAY730", 4,1)))

dt_long <- dt_long %>% distinct()
check <- checkData(dt_long) 
check_table[6,] = c(check["person"], check["row"])

# write.csv(dt_long, "./dt_long.csv")
write.csv(check_table, "./1229_va_check.csv")

dt_na <- na.omit(dt_long)
mean_dt <- dt_na %>%
  group_by(DAY) %>%
  summarise(mean=mean(LOGMAR), sd=sd(LOGMAR))

write.csv(mean_dt, "./1229_mean_va.csv")

## Initial Drug
bevaPeople <- drugData_ini %>% filter(DRUG_CLASS == "Bevacizumab")
raniPeople <- drugData_ini %>% filter(DRUG_CLASS == "Ranibizumab")
afliPeople <- drugData_ini %>% filter(DRUG_CLASS == "Aflibercept")

dt_long_drug <- dt_long %>%
  mutate(INI_DRUG = ifelse(SUBJECT_ID %in% bevaPeople$PERSON_ID, "Bevacizumab",
    ifelse(SUBJECT_ID %in% raniPeople$PERSON_ID, "Ranibizumab", 
      ifelse(SUBJECT_ID %in% afliPeople$PERSON_ID, "Aflibercept", "OTHER"))))


# dt_na_drug <- na.omit(dt_long_drug)
# mean_dt_drug <- dt_na_drug %>%
#   group_by(DAY, INI_DRUG) %>%
#   summarise(mean=mean(LOGMAR), sd =sd(LOGMAR))


write.csv(dt_long_drug, "./1229_dt_long_drug.csv")


## GEE
#  v <- as.numeric(dt_long$DAY_NUM >0)
# fit <- gee(LOGMAR ~ TIME, id = SUBJECT_ID, data = dt_long)
# sink("geefit.txt")
# summary(fit)
# sink()

# geeInd <- geeglm(LOGMAR ~ TIME, id = SUBJECT_ID, data = dt_long, family = gaussian)
# sink("geefit_ori.txt")
# summary(geeInd)
# sink()

# geeAlon <- gee(LOGMAR ~ TIME, id = SUBJECT_ID, data = dt_long, family = gaussian)
# sink("geefit_A.txt")
# summary(geeAlon)
# sink()


# extractOR(geeInd)
# options(ztable.type = "viewer")
# pdf("GEE.pdf")
# ztable(geeInd, digits = 4, caption = "Generalized Estimating Equation")
# graphics.off()
# dev.off()

