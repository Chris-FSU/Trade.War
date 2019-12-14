library(tidyverse)

### Data for 1962
data.yr<-read_rds("data/by.year/1962.rds")

# isolate exports
by.exp<-pivot_wider(data.yr, names_from = exporter, values_from = value)
by.exp[is.na(by.exp)] <- 0
# store vector of columns
expcols<-ncol(by.exp)-4

# isolate imports
by.imp<-pivot_wider(data.yr, id_cols =c("exporter","sitc4") , names_from = importer, values_from = value)
by.imp[is.na(by.imp)] <- 0
# store vector of columns
impcols<-ncol(by.imp)-2

# Pearson's correlation statistic for exports from each pair of countries
exp<-matrix(rep(NA,expcols*expcols),nrow=expcols)
imp<-matrix(rep(NA,impcols*impcols),nrow=impcols)

# Place each Pearson's correlation of exports into the appropriate cell
for (i in 1:expcols) {
  for (j in 1:expcols) {
    ifelse(i==j,NA,
           exp[i,j]<-cor(by.exp[i+4],by.exp[j+4],"pearson",use="pairwise.complete.obs"))
  }
}

# Place each Pearson's correlation  of imports into the appropriate cell
for (i in 1:impcols) {
  for (j in 1:impcols) {
    ifelse(i==j,NA,
           imp[i,j]<-cor(by.imp[i+2],by.imp[j+2],"pearson",use="pairwise.complete.obs"))
  }
}

# Name columns by country
colnames(exp)<-names(by.exp)[5:149]

# Make exports a dyadic dataset with two columns for country a and country b
exp<-as.data.frame(exp) %>%
  mutate(country.b = names(by.exp)[5:149]) %>%
  pivot_longer(cols = 1:145) %>%
  rename(country.a = name, exp.comp = value)

# Name import columns by country
colnames(imp)<-names(by.imp)[3:147]

# Make imports a dyadic dataset with two columns for country a and country b
imp<-as.data.frame(imp) %>%
  mutate(country.b = names(by.imp)[3:147]) %>%
  pivot_longer(cols = 1:145) %>%
  rename(country.a = name, imp.comp = value)

# combine imports and exports
comp.62<-left_join(exp,imp)

# Save it
write_rds(comp.62,"data/by.year/comp62.rds")

# clean up mess
rm(by.exp,by.imp,data.yr,exp,imp)



### Data for 1963
data.yr<-filter(data, year == 1963)
by.exp<-pivot_wider(data.yr, names_from = exporter, values_from = value)
expcols<-ncol(by.exp)-4
by.imp<-pivot_wider(data.yr, names_from = importer, values_from = value)
impcols<-ncol(by.imp)-4

# Pearson's correlation statistic for exports from each pair of countries
exp<-matrix(rep(NA,expcols*expcols),nrow=expcols)
imp<-matrix(rep(NA,impcols*impcols),nrow=impcols)
for (i in 1:expcols) {
  for (j in 1:expcols) {
    ifelse(i==j,NA,
           exp[i,j]<-cor(by.exp[i+4],by.exp[j+4],"pearson",use="pairwise.complete.obs"))
  }
}
for (i in 1:impcols) {
  for (j in 1:impcols) {
    ifelse(i==j,NA,
           imp[i,j]<-cor(by.imp[i+4],by.imp[j+4],"pearson",use="pairwise.complete.obs"))
  }
}

#
colnames(exp)<-names(by.exp)[5:(expcols+4)]
exp<-as.data.frame(exp) %>%
  mutate(country.b = names(by.exp)[5:(expcols+4)]) %>%
  pivot_longer(cols = 1:expcols) %>%
  rename(country.a = name, exp.comp = value)
colnames(imp)<-names(by.imp)[5:(impcols+4)]
imp<-as.data.frame(imp) %>%
  mutate(country.b = names(by.imp)[5:(impcols+4)]) %>%
  pivot_longer(cols = 1:impcols) %>%
  rename(country.a = name, imp.comp = value)
comp63<-left_join(exp,imp)
rm(by.exp,by.imp,data.yr,exp,imp)
