library(tidyverse)

data<-read_rds("data/massive.rds")

### Data for 1962
data.yr<-filter(data, year == 1962)
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
colnames(exp)<-names(by.exp)[5:149]
exp<-as.data.frame(exp) %>%
  mutate(country.b = names(by.exp)[5:149]) %>%
  pivot_longer(cols = 1:145) %>%
  rename(country.a = name, exp.comp = value)
colnames(imp)<-names(by.imp)[5:149]
imp<-as.data.frame(imp) %>%
  mutate(country.b = names(by.imp)[5:149]) %>%
  pivot_longer(cols = 1:145) %>%
  rename(country.a = name, imp.comp = value)
comp.62<-left_join(exp,imp)
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
