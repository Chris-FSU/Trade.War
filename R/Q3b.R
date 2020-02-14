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
neither <- read_rds("data/neither.rds") %>%
  select(country.a, statea, year, endyear,dispnum3,hiact,hostlev,fatality,victor)  %>%
  distinct
neither$pb.year <- ifelse(neither$year==neither$endyear,neither$endyear+1,neither$endyear)

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
losers$outcome <- "Loser"
winners$same.exp <-NA
for (i in 1:length(winners$statea)){
  try(winners$same.exp[i] <- cor(exports[,which(identifiers$statea==winners$statea[i] & identifiers$year==winners$year[i])],
                             exports[,which(identifiers$statea==winners$statea[i] & identifiers$year==winners$pb.year[i])],
                             method = "pearson",use = "pairwise.complete.obs"))
}
winners$outcome <- "Winner"
neither$same.exp <-NA
for (i in 1:length(neither$statea)){
  try(neither$same.exp[i] <- cor(exports[,which(identifiers$statea==neither$statea[i] & identifiers$year==neither$year[i])],
                             exports[,which(identifiers$statea==neither$statea[i] & identifiers$year==neither$pb.year[i])],
                             method = "pearson",use = "pairwise.complete.obs"))
}
neither$outcome <- "Neither"
winlose<-bind_rows(winners,losers,neither)
write_csv(winlose,"data/winlose.csv")
write_rds(winlose,"data/winlose.rds")

winlose <- read_rds("data/winlose.rds")

ggplot(winlose, aes(x=as.factor(outcome), y=same.exp)) + 
  geom_violin() +
  geom_boxplot(width=0.1) +
  labs(title="Losers Leave Markets", 
       subtitle = "Correlation of Pre-MID and Post-MID Exports by MID outcome") +
  ylab("Correlation of Pre-MID and Post-MID Exports") +
  xlab("") +
  theme_minimal()
ggsave("fig/LosersWeep.png",width=8,height=5)
summary(lm(same.exp~outcome,data=winlose))


hihost <-winlose[as.numeric(winlose$hostlev)>=4,]
ggplot(hihost, aes(x=as.factor(outcome), y=same.exp)) + 
  geom_violin() +
  geom_boxplot(width=0.1) +
  labs(title="When the Going Gets Tough ...", 
       subtitle = "Export Permanence in High Hostility MIDS") +
  ylab("Correlation of Exports Before and After MID") +
  xlab("") +
  theme_minimal()
ggsave("fig/LosersWeepHarder.png",width=8,height=5)
summary(lm(same.exp~outcome,data=hihost))

winlose$hostlev <-as.numeric(winlose$hostlev)
summary(lm(same.exp~outcome*hostlev,data=winlose))

winlose$loser <- 1 - winlose$victor
summary(lm(same.exp~loser*hostlev,data=winlose))
