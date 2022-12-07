library(remotes)
library(drat)
library(TreatmentPatterns)
library(tidyr)
library(stringr)
library(networkD3)
library(htmlwidgets)
library(webshot)

func1 <- function(data) {
  sankeyData <- c()
  for (j in data$TxPathway){
    txPathway<-c()
    treatment<-unlist(strsplit(j, '-'))
    
    for (i in 1:length(treatment)){
      txPathway <- c(txPathway, treatment[i])
    }
    sankeyData<-c(sankeyData, paste(txPathway, collapse = '-'))
  }
  sankeyData <- data.frame(table(sankeyData))
  
  sankeyData <- rename(sankeyData, "txPath"= "sankeyData")
  sankeyData <- rename(sankeyData, "count"= "Freq")
}


func2 <- function(sankeyData) {
  
  dataset2 <- sankeyData %>% separate(txPath, c('path1','path2','path3','path4'),'-')
  
  dataset3 <- dataset2[,-which(names(dataset2) %in% c('path4'))]
  dataset3[is.na(dataset3)] <- 'Stopped'
  dataset4 <- unite(dataset3, txPath, path1, path2, path3, sep = "-")
  
  dataset5 <- dataset4 %>% group_by(txPath) %>% summarize(count = sum(count))
  sum(dataset5$count)
  
  dataset5 <- dataset5[order(-dataset5[,2]),]
  
  dataset6 <- dataset5 %>% separate(txPath, c('path1','path2', 'path3'),'-')
  
  dataset6$event_cohort_name1 <- paste0("1.",dataset6$path1)
  dataset6$event_cohort_name2 <- paste0("2.",dataset6$path2)
  dataset6$event_cohort_name3 <- paste0("3.",dataset6$path3)
 
  return(dataset6)
}


func3 <- function(dataset6) {
  results1 <- dataset6 %>% 
    dplyr::group_by(event_cohort_name1,event_cohort_name2) %>% 
    dplyr::summarise(count = sum(count))
  
  results2 <- dataset6 %>% 
    dplyr::group_by(event_cohort_name2,event_cohort_name3) %>% 
    dplyr::summarise(count = sum(count))
  
  # Format in prep for sankey diagram
  colnames(results1) <- c("source", "target", "value")
  colnames(results2) <- c("source", "target", "value")
  links <- as.data.frame(rbind(results1,results2))
  links <- links[order(-links[,3]),]
  
  nodes <- data.frame(
    name=c(as.character(links$source), 
           as.character(links$target)) %>% unique()
  )
  links$IDsource <- match(links$source, nodes$name)-1 
  links$IDtarget <- match(links$target, nodes$name)-1
  plot <- sankeyNetwork(Links = links, Nodes =nodes,
                        Source = "IDsource", Target = "IDtarget",
                        Value = "value", NodeID = "name", #colourScale=JS(my_color),
                        fontSize= 12, nodeWidth = 30, 
                        iterations = FALSE,
                        sinksRight = FALSE)

}


source("./0_connection.R")


############ Data ###################

data = read.csv("./eyeData_for_plot.csv")
data <- data %>%
  select('PERSON_ID', 'TxPathway', "ROUTE_CLASS") %>% distinct()
## 08 ~ 19년도 
plotData_all <- data %>% 
  filter(PERIOD %in% "A" | PERIOD %in% "B" )
# 08 ~ 12
plotData_A <- data %>% 
  filter(PERIOD %in% "A" )
# 13 ~ 19

plotData_B <- data %>% 
  filter(PERIOD %in% "B")

############## PLOT ###############
sankeyData <- func1(plotData_all)
dataset6 <- func2(sankeyData)
linkAndNode_A <- func3(dataset6)
A <- data.frame(linkAndNode_A$links.source, linkAndNode_A$links.target,
                linkAndNode_A$links.value)
A <- rename(A, source=linkAndNode_A.links.source,
            target=linkAndNode_A.links.target,
            value=linkAndNode_A.links.value)
colnames(B)
rud
colnames(A)
linkAndNode_A
B <- as.data.frame(linkAndNode_A$nodes)
B <- rename(B, nodes=linkAndNode_A.nodes)
plot_all <- func4(A, B)

sankeyData <- func1(plotData_A)
dataset6 <- func2(sankeyData)
plot_A <- func3(dataset6)
plot_A

sankeyData <- func1(plotData_B)
dataset6 <- func2(sankeyData)
plot_B <- func3(dataset6)
plot_B

