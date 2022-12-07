rm(list = ls())
getwd()
source("./0_connection.R")
source("./1_processingFunctions.R")

eyeData_origin <- querySql(conn, "select * from g65829.eAMD_TX_allyear_csy")

id_all = read.csv("./id_all.csv")
id_A = read.csv("./id_A.csv")
id_B = read.csv("./id_B.csv")

eyeData <- eyeData_origin %>% 
  filter(PERSON_ID %in% id_all$PERSON_ID) %>%
  select(-c(DRUG_EXPOSURE_END_DATE, PERSONAL_DRUG_ASD_NUMBER))

table(eyeData$DRUG_CONCEPT_ID)

eyeData <- makeDrugClass(eyeData)

eyeData <- eyeData %>%
  group_by(PERSON_ID, DRUG_CLASS) %>%
  mutate(DRUG_ORDER = row_number()) %>%
  filter(DRUG_ORDER == 1)


eyeData <- eyeData %>%
  group_by(PERSON_ID) %>%
  arrange(DRUG_EXPOSURE_START_DATE) %>%
  mutate(TxPathway = paste(DRUG_CLASS, collapse = '-'))

eyeData_for_plot <- eyeData %>%
  ungroup(PERSON_ID)%>%
  select('TxPathway', 'PERSON_ID') %>% distinct()
eyeData_for_plot <- eyeData_for_plot %>%
  mutate(PERIOD = ifelse(PERSON_ID %in% id_A$PERSON_ID, "A",
                         ifelse(PERSON_ID %in% id_B$PERSON_ID, "B", "OTHER"))) %>%
  select(-c(PERSON_ID))

write.csv(eyeData_for_plot, file = "eyeData_for_plot_rep.csv")
