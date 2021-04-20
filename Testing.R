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


df1 <- structure(list(ID = c(3452L, 3452L, 6532L, 8732L, 3466L),
                      Date = c("02/01/2020", 
                               "02/01/2020", "06/01/2020", "09/01/2020", "20/01/2020"), Bug = c("A", 
                                                                                                "B", "D", "C", "A")), class = "data.frame", row.names = c(NA, 
                                                                                                                                                          -5L))

df1 <- df1 %>%
  mutate(Date = dmy(Date)) %>%
  group_by(Bug) %>%
  mutate(Flag = c(FALSE, diff(Date) < 14)) %>%
  ungroup


df1$Episode <- ifelse(df1$Flag == TRUE, "Yes", "No")

df1
