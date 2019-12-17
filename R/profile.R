library(tidyverse)
library(haven)
library(countrycode)

namesNcodes<-read_csv("data/names.and.codes.csv")
filenames<-paste0("data/nber/wtf", 62:99,".dta")
sets <- 1962:1999
for (jahr in 37:38){
  imp<-read_dta(filenames[jahr]) %>%
    pivot_wider(id_cols=c("year", "importer", "sitc4"),
                names_from = exporter, 
                values_from = value,
                values_fn = list(value = sum)) %>%
    select(1:4) %>%
    filter(sitc4 != "") %>%
    pivot_wider(id_cols = c("year","importer"),
                names_from = sitc4,
                values_from = World) %>%
    filter(importer != "World" &
             importer != "US NES" &
             importer != "Asia NES" &
             importer != "Areas NES")
  exp<-read_dta(filenames[jahr]) %>%
    pivot_wider(id_cols=c("year", "exporter", "sitc4"),
                names_from = importer, 
                values_from = value,
                values_fn = list(value = sum)) %>%
    select(1:4) %>%
    filter(sitc4 != "") %>%
    pivot_wider(id_cols = c("year","exporter"),
                names_from = sitc4,
                values_from = World) %>%
    filter(exporter != "World" &
             exporter != "US NES" &
             exporter != "Asia NES" &
             exporter != "Areas NES")
  for (i in 1:8){
    imp$importer[which(imp$importer %in% namesNcodes$old.name[i])]<-namesNcodes$new.name[i]
    exp$exporter[which(exp$exporter %in% namesNcodes$old.name[i])]<-namesNcodes$new.name[i]
  }
  imp[is.na(imp)] <- 0
  exp[is.na(exp)] <- 0
  imp<-mutate(imp, statea = countrycode(importer,'country.name','cown'))
  exp<-mutate(exp, statea = countrycode(exporter,'country.name','cown'))
  imp.filename<-paste0("data/profiles/imp",sets[jahr],".rds")
  write_rds(imp,imp.filename)
  exp.filename<-paste0("data/profiles/exp",sets[jahr],".rds")
  write_rds(exp,exp.filename)
  rm(imp,exp)
}

# One dataset to bring them all and in the darkness bind them
imports<-bind_rows(read_rds("data/profiles/imp1962.rds"),
                read_rds("data/profiles/imp1963.rds"),
                read_rds("data/profiles/imp1964.rds"),
                read_rds("data/profiles/imp1965.rds"),
                read_rds("data/profiles/imp1966.rds"),
                read_rds("data/profiles/imp1967.rds"),
                read_rds("data/profiles/imp1968.rds"),
                read_rds("data/profiles/imp1969.rds"),
                read_rds("data/profiles/imp1970.rds"),
                read_rds("data/profiles/imp1971.rds"),
                read_rds("data/profiles/imp1972.rds"),
                read_rds("data/profiles/imp1973.rds"),
                read_rds("data/profiles/imp1974.rds"),
                read_rds("data/profiles/imp1975.rds"),
                read_rds("data/profiles/imp1976.rds"),
                read_rds("data/profiles/imp1977.rds"),
                read_rds("data/profiles/imp1978.rds"),
                read_rds("data/profiles/imp1979.rds"),
                read_rds("data/profiles/imp1980.rds"),
                read_rds("data/profiles/imp1981.rds"),
                read_rds("data/profiles/imp1982.rds"),
                read_rds("data/profiles/imp1983.rds"),
                read_rds("data/profiles/imp1984.rds"),
                read_rds("data/profiles/imp1985.rds"),
                read_rds("data/profiles/imp1986.rds"),
                read_rds("data/profiles/imp1987.rds"),
                read_rds("data/profiles/imp1988.rds"),
                read_rds("data/profiles/imp1989.rds"),
                read_rds("data/profiles/imp1990.rds"),
                read_rds("data/profiles/imp1991.rds"),
                read_rds("data/profiles/imp1992.rds"),
                read_rds("data/profiles/imp1993.rds"),
                read_rds("data/profiles/imp1994.rds"),
                read_rds("data/profiles/imp1995.rds"),
                read_rds("data/profiles/imp1996.rds"),
                read_rds("data/profiles/imp1997.rds"),
                read_rds("data/profiles/imp1998.rds"),
                read_rds("data/profiles/imp1999.rds"))

# Get interstate war data
war<-read_csv("data/cow/directed_dyadic_war.csv") %>%
  filter(warstrtyr >1961) %>%
  select(statea,stateb,warstrtyr,warendyr,warolea,waroleb,wardyadrolea,wardyadroleb)

starts<-select(war,warstrtyr,statea,stateb,wardyadrolea,wardyadroleb) %>%
  rename(year = warstrtyr) %>%
  mutate(is.war = TRUE)

aggressors<-select(starts,year,statea,wardyadrolea) %>%
  filter(wardyadrolea == 1) %>%
  select(-wardyadrolea) %>%
  distinct()

defenders<-select(starts,year,statea,wardyadrolea) %>%
  filter(wardyadrolea == 3) %>%
  select(-wardyadrolea) %>%
  distinct()

# get trade data
years <- unique(aggressors$year)
trade <- read_dta("data/nber/wtf62.dta")
namesNcodes<-read_csv("data/names.and.codes.csv")
for (i in 1:8){
  trade$importer[which(trade$importer %in% namesNcodes$old.name[i])]<-namesNcodes$new.name[i]
  trade$exporter[which(trade$exporter %in% namesNcodes$old.name[i])]<-namesNcodes$new.name[i]
}
trade<-mutate(trade,statea = countrycode(country.a,'country.name','cown'))