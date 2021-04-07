######################################

######################################
install.packages('dplyr')
install.packages("S:\Business Intelligence - Covid Analytics Project\R Packages\dplyr_1.0.4", 
                 repos = NULL, 
                 type = "source")



library(dplyr)
library(lubridate)
library(tidyr)



setwd("S:/Business Intelligence - Covid Analytics Project/COVID-19 Antibiotic Prescribing Project (11)/Comms")
getwd()

Data <- read.csv('Strepto.csv')
head(Data)
table(Data)

Data <- data.frame(Data)
Data

#sort date column
Data <- Data[order(as.Date(Data$collection_date, format="%d/%m/%Y")),]

#Data<-Data %>% group_by(patient_id) %>% mutate(Year = ifelse(collection_date > collection_date,"1st Year","2nd Year"))

Data %>%
  mutate(Date = dmy(Date)) %>%
  group_by(patient_id) %>%
  mutate(flag =  replace_na(as.integer(difftime(collection_date , lag(collection_date ), units = 'day')) < 14, FALSE)) %>%
  ungroupData %>%
  mutate(collection_date  = dmy(collection_date )) %>%
  group_by(ID) %>%
  mutate(flag = c(FALSE, diff(collection_date ) < 14)) %>%
  ungroup



