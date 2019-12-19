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