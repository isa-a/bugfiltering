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
Data <- data.frame(Data)


#sort date column
Data <- Data[order(as.Date(Data$collection_date, format="%d/%m/%Y")),]

Data <- Data%>%
  mutate(collection_date = dmy(collection_date))%>%
  mutate(Episode=ifelse(is.na(lag(patient_id)), "No",
                        ifelse(patient_id==lag(patient_id) & collection_date-lag(collection_date)<14 & Bug==lag(Bug), "Yes", "No")))


write.csv(Data,"S:/Business Intelligence - Covid Analytics Project/COVID-19 Antibiotic Prescribing Project (11)/Comms/Output.csv", row.names = FALSE)




###########################################################################################################



Data <- Data %>%
  mutate(collection_date = dmy(collection_date)) %>%
  group_by(Bug) %>%
  mutate(Flag = c(FALSE, diff(collection_date) < 14)) %>%
  ungroup

Data$Episode <- ifelse(Data$Flag == TRUE, "Yes", "No")
