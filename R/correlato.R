library(tidyverse)

# This is necessary for the proper loading and saving within the loop
sets<- 1962:1999

# This loop automates everything.
for (annum in 1:length(sets)){
  
# load data
filename<-paste0("data/by.year/",sets[annum],".rds")
data.yr<-read_rds(filename)

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
comp<-left_join(exp,imp)

# Save it
output.filename<-paste0("data/by.year/comp",sets[annum],".rds")
write_rds(comp,output.filename)
rm(comp,exp,imp,by.exp,by.imp,impcols,expcols,data.yr)
}
