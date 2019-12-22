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

