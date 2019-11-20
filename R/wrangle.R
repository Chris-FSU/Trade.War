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
