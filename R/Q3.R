# Do losers stop dealing in the same goods as victors, once the war is over?
# First, do trade similarities decrease over the duration of a MID?

library(tidyverse)

data<- read_rds("data/comp.rds") %>%
  filter(!is.na(statea),
         !is.na(stateb)) %>%
  
  # This makes lagging easier.
  arrange(country.a,country.b,year) %>%
  
  # lag now to find deltas later
  mutate(lag.exp.comp = lag(exp.comp),
         lag.imp.comp = lag(imp.comp))

# dummy variable for whether an MID happened in that dyad-year
data$is.war<-ifelse(is.na(data$dispnum3),0,1)

# to avoid carrying over for deltas
data$lag.exp.comp[data$year==1962] <- data$lag.imp.comp[data$year==1962] <-NA

# Find deltas (t - (t-1))
data<- mutate(data,delta.exp.comp = exp.comp -lag.exp.comp,
         delta.imp.comp = imp.comp -lag.imp.comp)

mean(data$delta.exp.comp[data$is.war==1],na.rm=TRUE)
mean(data$delta.imp.comp[data$is.war==1],na.rm=TRUE)
mean(data$delta.exp.comp[data$is.war==0],na.rm=TRUE)
mean(data$delta.imp.comp[data$is.war==0],na.rm=TRUE)
sd(data$delta.imp.comp,na.rm=TRUE)
sd(data$delta.exp.comp,na.rm=TRUE)

# Trade similarities do not significantly decrease after 1 year of war.
# Test longer time gaps.

data<- read_rds("data/comp.rds") %>%
  filter(!is.na(statea),
         !is.na(stateb))

just.the.MIDs<-data[!is.na(data$dispnum3),]
just.the.MIDs$pb.imps<- just.the.MIDs$pb.exps<- NA
for (i in 1:length(just.the.MIDs$country.b)){
  just.the.MIDs$pb.imps[i]<-data$imp.comp[data$year==(just.the.MIDs$endyear[i]+1) & data$country.a == just.the.MIDs$country.a[i] & data$country.b == just.the.MIDs$country.b[i] ]
  just.the.MIDs$pb.exps[i]<-data$exp.comp[data$year==(just.the.MIDs$endyear[i]+1) &
                                            data$country.a == just.the.MIDs$country.a[i] &
                                            data$country.b == just.the.MIDs$country.b[i] ]
}
# The above loop stops at 160. I'm not yet sure why, but it's sleepy times. I'll figure it out in the morning.
just.the.MIDs$delta.exp.comp <- just.the.MIDs$pb.exps - just.the.MIDs$exp.comp
just.the.MIDs$delta.imp.comp <- just.the.MIDs$pb.imps - just.the.MIDs$imp.comp
