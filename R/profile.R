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

# Get interstate war data
war<-read_csv("data/cow/directed_dyadic_war.csv") %>%
  filter(warstrtyr >1961) %>%
  select(statea,warstrtyr,warolea) %>%
  rename(year = warstrtyr)

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
                read_rds("data/profiles/imp1999.rds")) %>%
  left_join(war)
imports[is.na(imports)] <- 0
write_rds(imports,"data/profiles/imports.rds")
write_csv(imports,"data/profiles/imports.csv")

# Or . . . two rather
exports<-bind_rows(read_rds("data/profiles/exp1962.rds"),
                   read_rds("data/profiles/exp1963.rds"),
                   read_rds("data/profiles/exp1964.rds"),
                   read_rds("data/profiles/exp1965.rds"),
                   read_rds("data/profiles/exp1966.rds"),
                   read_rds("data/profiles/exp1967.rds"),
                   read_rds("data/profiles/exp1968.rds"),
                   read_rds("data/profiles/exp1969.rds"),
                   read_rds("data/profiles/exp1970.rds"),
                   read_rds("data/profiles/exp1971.rds"),
                   read_rds("data/profiles/exp1972.rds"),
                   read_rds("data/profiles/exp1973.rds"),
                   read_rds("data/profiles/exp1974.rds"),
                   read_rds("data/profiles/exp1975.rds"),
                   read_rds("data/profiles/exp1976.rds"),
                   read_rds("data/profiles/exp1977.rds"),
                   read_rds("data/profiles/exp1978.rds"),
                   read_rds("data/profiles/exp1979.rds"),
                   read_rds("data/profiles/exp1980.rds"),
                   read_rds("data/profiles/exp1981.rds"),
                   read_rds("data/profiles/exp1982.rds"),
                   read_rds("data/profiles/exp1983.rds"),
                   read_rds("data/profiles/exp1984.rds"),
                   read_rds("data/profiles/exp1985.rds"),
                   read_rds("data/profiles/exp1986.rds"),
                   read_rds("data/profiles/exp1987.rds"),
                   read_rds("data/profiles/exp1988.rds"),
                   read_rds("data/profiles/exp1989.rds"),
                   read_rds("data/profiles/exp1990.rds"),
                   read_rds("data/profiles/exp1991.rds"),
                   read_rds("data/profiles/exp1992.rds"),
                   read_rds("data/profiles/exp1993.rds"),
                   read_rds("data/profiles/exp1994.rds"),
                   read_rds("data/profiles/exp1995.rds"),
                   read_rds("data/profiles/exp1996.rds"),
                   read_rds("data/profiles/exp1997.rds"),
                   read_rds("data/profiles/exp1998.rds"),
                   read_rds("data/profiles/exp1999.rds")) %>%
  left_join(war)
exports[is.na(exports)] <- 0
write_rds("data/profiles/exports.rds")
write_csv("data/profiles/exports.csv")

# Mean was just not working, so I did this.
meaner<-function(x){
    sum(x,na.rm=TRUE)/length(na.omit(x))
}

at.peace <- offense <- cooffense <- defence <- codefence <-NA
for (i in 3:1692) {
  at.peace[i] <- meaner(data[data$warolea == 0,i])
  offense[i] <- meaner(data[data$warolea == 1,i])
  cooffense[i] <- meaner(data[data$warolea == 2,i])
  defence[i] <- meaner(data[data$warolea == 3,i])
  codefence[i] <- meaner(data[data$warolea == 4,i])
}
averages<-as.data.frame(matrix(c(at.peace,offense,cooffense,defence,codefence),ncol=5))


