Sys.setlocale(category = "LC_ALL", locale = "us")

library(SqlRender)
# library(DatabaseConnector)
library(dplyr)
library(sunburstR)
options(scipen=100)


user <- "G65829"
pw <- ""
server <- ""
port <- ""
dbms <-"oracle"
pathToDriver <- ""

connectionDetails <- createConnectionDetails(dbms=dbms,
                                             server=server,
                                             user=user,
                                             password=pw,
                                             port=port,
                                             pathToDriver = pathToDriver)

conn <- connect(connectionDetails)

## TODO : DRUG CONCEPT ID 
drug_beva <- c('1397141')
drug_rani <- c('43286611')
drug_afli <- c('35606176')
drug_vert <- c('1593778')

drug_all <- c(drug_beva, drug_rani, drug_afli, drug_vert) 

## TODO : ROUTE CONCEPT ID 
right <- c("2000000433")
left <- c("2000000434")
bi <- c("2000000435")
intra_ocular <- c("4157760")
intra_venous <- c("4171047")
intra_vitreal <- c("4302785")

print("connection finish")
