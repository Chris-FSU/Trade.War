library(tidyverse)
library(countrycode)

# Get interstate war data
war<-read_csv("data/cow/directed_dyadic_war.csv") %>%
  filter(warstrtyr >1961) %>%
  select(statea,stateb,warstrtyr,warendyr,warolea,waroleb,wardyadrolea,wardyadroleb)

# Read in a correlation set
comp62<-read_rds("data/by.year/comp1962.rds") %>%
  mutate(statea = countrycode(country.a,'country.name','cown'),
         stateb = countrycode(country.a,'country.name','cown'))
