# Do losers' exports change more than winners' exports?
library(tidyverse)

winners <- read_rds("data/victors.rds") %>%
  select(country.a, statea, year, endyear,dispnum3,hiact,hostlev,fatality,victor) %>%
  distinct
winners$pb.year <- ifelse(winners$year==winners$endyear,winners$endyear+1,winners$endyear)
losers <- read_rds("data/losers.rds") %>%
  select(country.a, statea, year, endyear,dispnum3,hiact,hostlev,fatality,victor)  %>%
  distinct
losers$pb.year <- ifelse(losers$year==losers$endyear,losers$endyear+1,losers$endyear)

exports<-read_rds("data/AllExps.rds")
identifiers<-select(exports,importer,year,statea)
exports<-select(exports,-importer,-year,-statea) %>%
  t %>% as.data.frame


losers$same.exp <-NA
for (i in 1:length(losers$statea)){
  try(losers$same.exp[i] <- cor(exports[,which(identifiers$statea==losers$statea[i] & identifiers$year==losers$year[i])],
      exports[,which(identifiers$statea==losers$statea[i] & identifiers$year==losers$pb.year[i])],
      method = "pearson",use = "pairwise.complete.obs"))
}
winners$same.exp <-NA
for (i in 57:length(winners$statea)){
  winners$same.exp[i] <- cor(exports[,which(identifiers$statea==winners$statea[i] & identifiers$year==winners$year[i])],
                             exports[,which(identifiers$statea==winners$statea[i] & identifiers$year==winners$pb.year[i])],
                             method = "pearson",use = "pairwise.complete.obs")
}

winlose<-bind_rows(winners,losers)
# write_csv(winlose,"data/winlose.csv")
# write_rds(winlose,"data/winlose.rds")

#winlose <- read_rds("data/winlose.rds")

ggplot(winlose, aes(x=as.logical(victor), y=same.exp)) + 
  geom_violin() +
  geom_boxplot(width=0.1) +
  labs(title="Do Losers Leave Markets?", subtitle = "Yes, they do.") +
  ylab("Correlation of Exports at T1 and at T2") +
  xlab("Winner") +
  theme_minimal()
# ggsave("fig/LosersWeep.png",width=8,height=5)
summary(lm(same.exp~victor,data=winlose))

winlose$hostlev <-as.numeric(winlose$hostlev)
summary(lm(same.exp~victor*hostlev,data=winlose))

winlose$loser <- 1 - winlose$victor
summary(lm(same.exp~loser*hostlev,data=winlose))
