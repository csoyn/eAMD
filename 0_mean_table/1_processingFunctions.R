checkData <- function(data) {
  return(
    c(person=length(unique(data$PERSON_ID)), row= nrow(data))
  )
}

# 처방순서매김 PERSON_DRUG_ASD_NUMBER -> row_number
orderExposure <- function(data) {
  data <- data %>% 
    group_by(PERSON_ID) %>%
    arrange(PERSON_ID,DRUG_EXPOSURE_START_DATE) %>%
    mutate(PERSON_DRUG_ASD_NUMBER = row_number())
  return (
    data
  )
}
#
extractFirstDate <- function(data) {
  newData <- data %>%
    group_by(PERSON_ID) %>%
    mutate(FIRST_EXPOSURE_DATE = min(DRUG_EXPOSURE_START_DATE))
  newData["DAY_DIFF"] = newData["DRUG_EXPOSURE_START_DATE"] - newData["FIRST_EXPOSURE_DATE"]
  return(
    newData
  )
}


extractID <- function(data, period) {
  if (period == "all") {
    IDs <- subset(data, select = c(PERSON_ID)
                  , PERSON_DRUG_ASD_NUMBER == 1  &
                    DRUG_EXPOSURE_START_DATE >= "2008-01-01" & DRUG_EXPOSURE_START_DATE < "2020-01-01")
  } else if (period == "A") {
    IDs <- subset(data, select = c(PERSON_ID)
                  , PERSON_DRUG_ASD_NUMBER == 1  &
                    DRUG_EXPOSURE_START_DATE >= "2008-01-01" & DRUG_EXPOSURE_START_DATE < "2013-01-01")
  } else if (period == "B") {
    IDs <- subset(data, select = c(PERSON_ID)
                  , PERSON_DRUG_ASD_NUMBER == 1  &
                    DRUG_EXPOSURE_START_DATE >= "2013-01-01" & DRUG_EXPOSURE_START_DATE < "2020-01-01")
  } 
  
  return( 
    IDs
  )
}


extractDrugFirstDate <- function(data) {
  newData <-data %>%
    group_by(PERSON_ID, DRUG_CONCEPT_ID) %>%
    arrange(PERSON_ID,DRUG_EXPOSURE_START_DATE) %>%
    mutate(MIN_DATE = min(DRUG_EXPOSURE_START_DATE))
  newData <- newData[order(newData$PERSON_ID, newData$MIN_DATE) ,]
  return(newData)
}



makeDrugClass <- function(data) {
  newData <-data %>%
    mutate(DRUG_CLASS = 
             ifelse(DRUG_CONCEPT_ID %in% drug_beva, "Bevacizumab",
                    ifelse(DRUG_CONCEPT_ID %in% drug_rani, "Ranibizumab",
                           ifelse(DRUG_CONCEPT_ID %in% drug_afli, "Aflibercept",
                                  ifelse(DRUG_CONCEPT_ID %in% drug_vert, "Verteporfin", "Others")))))
  return (newData)
}


makeTotalCount <- function(data) {
  newData <- data %>% group_by(PERSON_ID) %>%
    mutate(DRUG_TOTAL_COUNT = max(PERSON_DRUG_ASD_NUMBER))
  return (newData)
}


makeEachCount <- function(data) {
  newData <- data %>% group_by(PERSON_ID, DRUG_CLASS) %>%
    mutate(DRUG_COUNT = max(row_number()))
}


makeEachCountCol <- function(data) {
  newData <- data %>%
    mutate(BEVA_COUNT = ifelse(DRUG_CLASS == "Bevacizumab", DRUG_COUNT, 0))
  newData <- newData %>%
    mutate(RANI_COUNT = ifelse(DRUG_CLASS == "Ranibizumab", DRUG_COUNT, 0))
  newData <- newData %>%
    mutate(AFLI_COUNT = ifelse(DRUG_CLASS == "Aflibercept", DRUG_COUNT, 0))
  newData <- newData %>%
    mutate(VERT_COUNT = ifelse(DRUG_CLASS == "Verteporfin", DRUG_COUNT, 0))
  return(newData)
}


firstDrugID <- function(data, drugName) {
  if (drugName == "Bevacizumab") {
    newData <- data %>% 
      filter(PERSON_DRUG_ASD_NUMBER == 1 & DRUG_CLASS == "Bevacizumab") %>%
      select(c(PERSON_ID, DRUG_CLASS, PERSON_DRUG_ASD_NUMBER, MIN_DATE))
  } else if (drugName == "Ranibizumab") {
    newData <- data %>% 
      filter(PERSON_DRUG_ASD_NUMBER == 1 & DRUG_CLASS == "Ranibizumab") %>%
      select(c(PERSON_ID, DRUG_CLASS, PERSON_DRUG_ASD_NUMBER, MIN_DATE))    
  } else if (drugName == "Aflibercept") {
    newData <- data %>% 
      filter(PERSON_DRUG_ASD_NUMBER == 1 & DRUG_CLASS == "Aflibercept") %>%
      select(c(PERSON_ID, DRUG_CLASS, PERSON_DRUG_ASD_NUMBER, MIN_DATE))    
  } else if (drugName == "Verteporfin") {
    newData <- data %>% 
      filter(PERSON_DRUG_ASD_NUMBER == 1 & DRUG_CLASS == "Verteporfin") %>%
      select(c(PERSON_ID, DRUG_CLASS, PERSON_DRUG_ASD_NUMBER, MIN_DATE))    
  } else {
    return ()
  }
  return (newData)

}

print("import functions finish")

































