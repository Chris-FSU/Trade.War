library(tidyverse)
library(haven)
library(countrycode)

namesNcodes<-read_csv("data/names.and.codes.csv")
filenames<-paste0("data/nber/wtf", 62:99,".dta")
sets <- 1962:1999
for (jahr in 4:38){
  data.yr<-read_dta(filenames[jahr]) %>%
    select(year, importer, exporter, sitc4, value) %>%
    # None of these have COW codes, so they are useless to this analysis.
    filter(importer != "US NES" &
             importer != "Asia NES" &
             importer != "Areas NES" &
             importer != "Bermuda" &
             importer != "Fr Ind O" &
             importer != "Fr.Guiana" &
             importer != "Gibraltar" &
             importer != "Greenland" &
             importer != "Guadeloupe" &
             importer != "New Caledonia") %>%
    filter(exporter != "US NES" &
             exporter != "Asia NES" &
             exporter != "Areas NES" &
             exporter != "Bermuda" &
             exporter != "Fr Ind O" &
             exporter != "Fr.Guiana" &
             exporter != "Gibraltar" &
             exporter != "Greenland" &
             exporter != "Guadeloupe" &
             exporter != "New Caledonia")
  
  # change names to names that countrycodes will recognize later
  for (i in 1:8){
    data.yr$importer[which(data.yr$importer %in% namesNcodes$old.name[i])]<-namesNcodes$new.name[i]
    data.yr$exporter[which(data.yr$exporter %in% namesNcodes$old.name[i])]<-namesNcodes$new.name[i]
  }
  
  # isolate exports
  by.exp<-filter(data.yr,sitc4 != "") %>%
    pivot_wider(id_cols =c("importer","sitc4"), names_from = exporter, values_from = value, values_fn=list(value = sum)) %>%
    # Drop all importers except the world sum
    select(1:4) %>%
    # Separate columns by product.
    pivot_wider(names_from = sitc4, id_cols=importer, values_from = World, values_fn=list(value = sum)) %>%
    # Insert year variable
    mutate(year=sets[jahr])
  # Turn NAs into zeros.
  by.exp[is.na(by.exp)] <- 0
  
  # isolate imports
  by.imp<-filter(data.yr,sitc4 != "") %>%
    pivot_wider(id_cols =c("exporter","sitc4"), names_from = importer, values_from = value, values_fn=list(value = sum)) %>%
    # Drop all exporters except the world sum
    select(1:4) %>%
    # Separate columns by product.
    pivot_wider(names_from = sitc4, id_cols=exporter,values_from = World, values_fn=list(value = sum)) %>%
    # Insert year variable
    mutate(year=sets[jahr])
  # Turn NAs into zeros.
  by.imp[is.na(by.imp)] <- 0
  write_rds(by.exp,paste0("data/by.year/fullexp",sets[jahr],".rds"))
  write_rds(by.imp,paste0("data/by.year/fullimp",sets[jahr],".rds"))
  write_csv(by.exp,paste0("data/by.year/fullexp",sets[jahr],".csv"))
  write_csv(by.imp,paste0("data/by.year/fullimp",sets[jahr],".csv"))

  rm(by.exp,by.imp,data.yr)
# Later, you'll regress this on different MID variables.
}

allImps<-bind_rows(read_rds("data/by.year/fullimp1962.rds"),
                  read_rds("data/by.year/fullimp1963.rds"),
                  read_rds("data/by.year/fullimp1964.rds"),
                  read_rds("data/by.year/fullimp1965.rds"),
                  read_rds("data/by.year/fullimp1966.rds"),
                  read_rds("data/by.year/fullimp1967.rds"),
                  read_rds("data/by.year/fullimp1968.rds"),
                  read_rds("data/by.year/fullimp1969.rds"),
                  read_rds("data/by.year/fullimp1970.rds"),
                  read_rds("data/by.year/fullimp1971.rds"),
                  read_rds("data/by.year/fullimp1972.rds"),
                  read_rds("data/by.year/fullimp1973.rds"),
                  read_rds("data/by.year/fullimp1974.rds"),
                  read_rds("data/by.year/fullimp1975.rds"),
                  read_rds("data/by.year/fullimp1976.rds"),
                  read_rds("data/by.year/fullimp1977.rds"),
                  read_rds("data/by.year/fullimp1978.rds"),
                  read_rds("data/by.year/fullimp1979.rds"),
                  read_rds("data/by.year/fullimp1980.rds"),
                  read_rds("data/by.year/fullimp1981.rds"),
                  read_rds("data/by.year/fullimp1982.rds"),
                  read_rds("data/by.year/fullimp1983.rds"),
                  read_rds("data/by.year/fullimp1984.rds"),
                  read_rds("data/by.year/fullimp1985.rds"),
                  read_rds("data/by.year/fullimp1986.rds"),
                  read_rds("data/by.year/fullimp1987.rds"),
                  read_rds("data/by.year/fullimp1988.rds"),
                  read_rds("data/by.year/fullimp1989.rds"),
                  read_rds("data/by.year/fullimp1990.rds"),
                  read_rds("data/by.year/fullimp1991.rds"),
                  read_rds("data/by.year/fullimp1992.rds"),
                  read_rds("data/by.year/fullimp1993.rds"),
                  read_rds("data/by.year/fullimp1994.rds"),
                  read_rds("data/by.year/fullimp1995.rds"),
                  read_rds("data/by.year/fullimp1996.rds"),
                  read_rds("data/by.year/fullimp1997.rds"),
                  read_rds("data/by.year/fullimp1998.rds"),
                  read_rds("data/by.year/fullimp1999.rds")) %>%
  mutate(statea = countrycode(exporter,'country.name','cown')) %>%
write_rds("data/allImps.rds") %>%
write_csv("data/allImps.csv")

allExps<-bind_rows(read_rds("data/by.year/fullexp1962.rds"),
                   read_rds("data/by.year/fullexp1963.rds"),
                   read_rds("data/by.year/fullexp1964.rds"),
                   read_rds("data/by.year/fullexp1965.rds"),
                   read_rds("data/by.year/fullexp1966.rds"),
                   read_rds("data/by.year/fullexp1967.rds"),
                   read_rds("data/by.year/fullexp1968.rds"),
                   read_rds("data/by.year/fullexp1969.rds"),
                   read_rds("data/by.year/fullexp1970.rds"),
                   read_rds("data/by.year/fullexp1971.rds"),
                   read_rds("data/by.year/fullexp1972.rds"),
                   read_rds("data/by.year/fullexp1973.rds"),
                   read_rds("data/by.year/fullexp1974.rds"),
                   read_rds("data/by.year/fullexp1975.rds"),
                   read_rds("data/by.year/fullexp1976.rds"),
                   read_rds("data/by.year/fullexp1977.rds"),
                   read_rds("data/by.year/fullexp1978.rds"),
                   read_rds("data/by.year/fullexp1979.rds"),
                   read_rds("data/by.year/fullexp1980.rds"),
                   read_rds("data/by.year/fullexp1981.rds"),
                   read_rds("data/by.year/fullexp1982.rds"),
                   read_rds("data/by.year/fullexp1983.rds"),
                   read_rds("data/by.year/fullexp1984.rds"),
                   read_rds("data/by.year/fullexp1985.rds"),
                   read_rds("data/by.year/fullexp1986.rds"),
                   read_rds("data/by.year/fullexp1987.rds"),
                   read_rds("data/by.year/fullexp1988.rds"),
                   read_rds("data/by.year/fullexp1989.rds"),
                   read_rds("data/by.year/fullexp1990.rds"),
                   read_rds("data/by.year/fullexp1991.rds"),
                   read_rds("data/by.year/fullexp1992.rds"),
                   read_rds("data/by.year/fullexp1993.rds"),
                   read_rds("data/by.year/fullexp1994.rds"),
                   read_rds("data/by.year/fullexp1995.rds"),
                   read_rds("data/by.year/fullexp1996.rds"),
                   read_rds("data/by.year/fullexp1997.rds"),
                   read_rds("data/by.year/fullexp1998.rds"),
                   read_rds("data/by.year/fullexp1999.rds")) %>%
  mutate(statea = countrycode(importer,'country.name','cown')) %>%
  write_rds("data/allExps.rds") %>%
  write_csv("data/allExps.csv")

# Adding War data
allExps[is.na(allExps)] <- 0
allExps <- left_join(allExps,read_rds("data/MID.rds")) %>%
  filter(importer != 'World')
allExps <- mutate(allExps, is.peace = is.na(allExps$dispnum3))

set <- as.data.frame(matrix(names(allExps)))
set$noMID <- set$MID <- NA
for (i in 2:1691) {
  temp1 <- allExps[,i]
  temp1 <- temp1  * allExps$is.peace
  set$noMID[i] <- sum(temp1)/length(temp1[temp1 >0])
  temp2 <- allExps[,i]
  temp2 <- temp2  * (1 - allExps$is.peace)
  set$MID[i] <- sum(temp2)/length(temp2[temp2 >0])
}
set$diff <- set$MID - set$noMID

set <- arrange(set, diff) %>%
  filter(!is.na(diff))
set$V1[1:5]
