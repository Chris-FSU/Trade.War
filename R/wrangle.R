library(tidyverse)
library(haven)
library(countrycode)

# If this dataset weren't massive, I'd read and join all of the data before
# shrinking it. Since it is very very large, I'm going about it a different
# way. I apologize for any confusion this might cause.

data<-read_dta("data/nber/wtf62.dta") %>%
  select(year, importer, exporter, sitc4, value) %>%
  #None of these have COW codes, so they are useless to this analysis.
  filter(importer != "World" &
           importer != "US NES" &
           importer != "Asia NES" &
           importer != "Areas NES" &
           importer != "Bermuda" &
           importer != "Fr Ind O" &
           importer != "Fr.Guiana" &
           importer != "Gibraltar" &
           importer != "Greenland" &
           importer != "Guadeloupe" &
           importer != "New Caledonia") %>%
  filter(exporter != "World" &
           exporter != "US NES" &
           exporter != "Asia NES" &
           exporter != "Areas NES" &
           exporter != "Bermuda" &
           exporter != "Fr Ind O" &
           exporter != "Fr.Guiana" &
           exporter != "Gibraltar" &
           exporter != "Greenland" &
           exporter != "Guadeloupe" &
           exporter != "New Caledonia")

filenames<-paste0("data/nber/wtf", 62:99,".dta")
for (i in 2:38){
  temp<-read_dta(filenames[i]) %>%
    select(year, importer, exporter, sitc4, value) %>%
    # None of these have COW codes, so they are useless to this analysis.
    filter(importer != "World" &
             importer != "US NES" &
             importer != "Asia NES" &
             importer != "Areas NES" &
             importer != "Bermuda" &
             importer != "Fr Ind O" &
             importer != "Fr.Guiana" &
             importer != "Gibraltar" &
             importer != "Greenland" &
             importer != "Guadeloupe" &
             importer != "New Caledonia") %>%
    filter(exporter != "World" &
             exporter != "US NES" &
             exporter != "Asia NES" &
             exporter != "Areas NES" &
             exporter != "Bermuda" &
             exporter != "Fr Ind O" &
             exporter != "Fr.Guiana" &
             exporter != "Gibraltar" &
             exporter != "Greenland" &
             exporter != "Guadeloupe" &
             exporter != "New Caledonia")
  data<-bind_rows(data,temp)
}
write_rds(data,"data/massive.rds")
write_csv(data,"data/massive.csv")

data62<-filter(data, year == 1962) %>%
  write_rds("data/by.year/1962.rds") %>%
  rm()
data63<-filter(data, year == 1963) %>%
  write_rds("data/by.year/1963.rds") %>%
  rm()
data64<-filter(data, year == 1964) %>%
  write_rds("data/by.year/1964.rds") %>%
  rm()
data65<-filter(data, year == 1965) %>%
  write_rds("data/by.year/1965.rds") %>%
  rm()
data66<-filter(data, year == 1966) %>%
  write_rds("data/by.year/1966.rds") %>%
  rm()
data67<-filter(data, year == 1967) %>%
  write_rds("data/by.year/1967.rds") %>%
  rm()
data68<-filter(data, year == 1968) %>%
  write_rds("data/by.year/1968.rds") %>%
  rm()
data69<-filter(data, year == 1969) %>%
  write_rds("data/by.year/1969.rds") %>%
  rm()
data70<-filter(data, year == 1970) %>%
  write_rds("data/by.year/1970.rds") %>%
  rm()
data71<-filter(data, year == 1971) %>%
  write_rds("data/by.year/1971.rds") %>%
  rm()
data72<-filter(data, year == 1972) %>%
  write_rds("data/by.year/1972.rds") %>%
  rm()
data73<-filter(data, year == 1973) %>%
  write_rds("data/by.year/1973.rds") %>%
  rm()
data74<-filter(data, year == 1974) %>%
  write_rds("data/by.year/1974.rds") %>%
  rm()
data75<-filter(data, year == 1975) %>%
  write_rds("data/by.year/1975.rds") %>%
  rm()
data76<-filter(data, year == 1976) %>%
  write_rds("data/by.year/1976.rds") %>%
  rm()
data77<-filter(data, year == 1977) %>%
  write_rds("data/by.year/1977.rds") %>%
  rm()
data78<-filter(data, year == 1978) %>%
  write_rds("data/by.year/1978.rds") %>%
  rm()
data79<-filter(data, year == 1979) %>%
  write_rds("data/by.year/1979.rds") %>%
  rm()
data80<-filter(data, year == 1980) %>%
  write_rds("data/by.year/1980.rds") %>%
  rm()
data81<-filter(data, year == 1981) %>%
  write_rds("data/by.year/1981.rds") %>%
  rm()
data82<-filter(data, year == 1982) %>%
  write_rds("data/by.year/1982.rds") %>%
  rm()
data83<-filter(data, year == 1983) %>%
  write_rds("data/by.year/1983.rds") %>%
  rm()
data84<-filter(data, year == 1984) %>%
  write_rds("data/by.year/1984.rds") %>%
  rm()
data85<-filter(data, year == 1985) %>%
  write_rds("data/by.year/1985.rds") %>%
  rm()
data86<-filter(data, year == 1986) %>%
  write_rds("data/by.year/1986.rds") %>%
  rm()
data87<-filter(data, year == 1987) %>%
  write_rds("data/by.year/1987.rds") %>%
  rm()
data88<-filter(data, year == 1988) %>%
  write_rds("data/by.year/1988.rds") %>%
  rm()
data89<-filter(data, year == 1989) %>%
  write_rds("data/by.year/1989.rds") %>%
  rm()
data90<-filter(data, year == 1990) %>%
  write_rds("data/by.year/1990.rds") %>%
  rm()
data91<-filter(data, year == 1991) %>%
  write_rds("data/by.year/1991.rds") %>%
  rm()
data92<-filter(data, year == 1992) %>%
  write_rds("data/by.year/1992.rds") %>%
  rm()
data93<-filter(data, year == 1993) %>%
  write_rds("data/by.year/1993.rds") %>%
  rm()
data94<-filter(data, year == 1994) %>%
  write_rds("data/by.year/1994.rds") %>%
  rm()
data95<-filter(data, year == 1995) %>%
  write_rds("data/by.year/1995.rds") %>%
  rm()
data96<-filter(data, year == 1996) %>%
  write_rds("data/by.year/1996.rds") %>%
  rm()
data97<-filter(data, year == 1997) %>%
  write_rds("data/by.year/1997.rds") %>%
  rm()
data98<-filter(data, year == 1998) %>%
  write_rds("data/by.year/1998.rds") %>%
  rm()
data99<-filter(data, year == 1999) %>%
  write_rds("data/by.year/1999.rds") %>%
  rm()
