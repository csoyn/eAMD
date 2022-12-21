# TODO : FeatureExtration이 깔려있어야 함
library(FeatureExtration)
library(SqlRender)
library(DatabaseConnector)
library(dplyr)

options(scipen=100)

# TODO : DB정보 입력
user <- ""
pw <- ""
server <- ""
port <- ""
dbms <-""
pathToDriver <- ""

connectionDetails <- createConnectionDetails(dbms=dbms,
  server=server,
  user=user,
  password=pw,
  port=port,
  pathToDriver = pathToDriver)

conn <- connect(connectionDetails)


covariateSetting <- createDefaultCovariateSetting
covariateSetting

covariateData <- getDbCovariateData(connectionDetails = connectionDetails,
                  cdmDatabaseSchema = "CDM_2019_VIEW", # TODO 변경
                  cohortDatabaseSchema = "G65829",     # TODO 변경
                  cohortTable = "eAMD_TX_allyear_csy", # tabel 명 동일하게 사용했던 것 같음
                  rowIdField = "SUBJECT_ID",
                  covariateSettings = covariateSettings,
                  aggregated = TRUE)


covariateData$covariates

result <- createTable1(covariateData, showCounts = TRUE, showPercent = TRUE)

write.csv(result, file = "./suppTable.csv")



































