Sys.setlocale(category = "LC_ALL", locale = "us")

library(SqlRender)
library(DatabaseConnector)
library(dplyr)
options(scipen=100)

# TODO : DB정보 입력
user <- "G65829"
pw <- "g65829"
server <- "localhost/snuhos"
port <- "1521"
dbms <-"oracle"
pathToDriver <- "C:/Program Files/sqldeveloper/jdbc/lib"

connectionDetails <- createConnectionDetails(dbms=dbms,
                                             server=server,
                                             user=user,
                                             password=pw,
                                             port=port,
                                             pathToDriver = pathToDriver)

conn <- connect(connectionDetails)

# TODO : drug_concept_id 입력
drug_beva <- c('1397141')
drug_rani <- c('43286611')
drug_afli <- c('35606176')
drug_vert <- c('1593778')

drug_all <- c(drug_beva, drug_rani, drug_afli, drug_vert) 

checkData <- function(data) {
  return(
    c(person=length(unique(data$PERSON_ID)), row= nrow(data))
  )
}


print("connection finish")