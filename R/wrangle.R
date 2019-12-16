library(tidyverse)
library(haven)
library(countrycode)

# If this dataset weren't massive, I'd read and join all of the data before
# shrinking it. Since it is very very large, I'm going about it a different
# way. I apologize for any confusion this might cause.

filenames<-paste0("data/nber/wtf", 62:99,".dta")
for (jahr in 1:38){
  data.yr<-read_dta(filenames[jahr]) %>%
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
  # isolate exports
  by.exp<-pivot_wider(data.yr, names_from = exporter, values_from = value, values_fn=list(value = sum))
  by.exp[is.na(by.exp)] <- 0
  # store vector of columns
  expcols<-ncol(by.exp)-4
  
  # isolate imports
  by.imp<-pivot_wider(data.yr, id_cols =c("exporter","sitc4") , names_from = importer, values_from = value, values_fn=list(value = sum))
  by.imp[is.na(by.imp)] <- 0
  # store vector of columns
  impcols<-ncol(by.imp)-2
  
  # Initialize exp and imp
  exp<-matrix(rep(NA,expcols*expcols),nrow=expcols)
  imp<-matrix(rep(NA,impcols*impcols),nrow=impcols)
  
  # Insert Pearson's correlations for exp
  for (i in 1:expcols) {
    for (j in 1:expcols) {
      ifelse(i==j,NA,
             exp[i,j]<-cor(by.exp[i+4],by.exp[j+4],"pearson",use="pairwise.complete.obs"))
    }
  }
  
  # Insert Pearson's correlations for imp
  for (i in 1:impcols) {
    for (j in 1:impcols) {
      ifelse(i==j,NA,
             imp[i,j]<-cor(by.imp[i+2],by.imp[j+2],"pearson",use="pairwise.complete.obs"))
    }
  }
  
  # Make exp a dataframe
  colnames(exp)<-names(by.exp)[5:(expcols+4)]
  exp<-as.data.frame(exp) %>%
    mutate(country.b = names(by.exp)[5:(expcols+4)]) %>%
    pivot_longer(cols = 1:expcols) %>%
    rename(country.a = name, exp.comp = value)
  
  # Make imp a dataframe
  colnames(imp)<-names(by.imp)[3:(impcols+2)]
  imp<-as.data.frame(imp) %>%
    mutate(country.b = names(by.imp)[3:(impcols+2)]) %>%
    pivot_longer(cols = 1:impcols) %>%
    rename(country.a = name, imp.comp = value)
  
  # Combine them
  comp<-left_join(exp,imp) %>%
    # Enter cow codes
    mutate(statea = countrycode(country.a,'country.name','cown'),
           stateb = countrycode(country.a,'country.name','cown'))
  
  # Save it
  output.filename<-paste0("data/by.year/comp",sets[annum],".rds")
  write_rds(comp,output.filename)
  rm(comp,exp,imp,by.exp,by.imp,impcols,expcols,data.yr)
}