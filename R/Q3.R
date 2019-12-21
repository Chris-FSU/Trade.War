# Do losers stop dealing in the same goods as victors, once the war is over?
# First, do trade similarities decrease over the duration of a MID?

library(tidyverse)

data<- read_rds("data/comp.rds") %>%
  filter(!is.na(statea),
         !is.na(stateb))

# Make a dataset of just the MID dyadyears
MIDsub<-data[!is.na(data$dispnum3),]
MIDsub$pb.imps<- MIDsub$pb.exps<- NA
# There are some cases of missing data. This loop will generate an error for each iteration of missing data.
# Because of the try() function, the loop will continue nonetheless.
for (i in 1:length(MIDsub$country.b)){
  try(
  MIDsub$pb.imps[i]<-data$imp.comp[data$year==(MIDsub$endyear[i]+1) & 
                                            data$statea == MIDsub$statea[i] & 
                                            data$stateb == MIDsub$stateb[i] ]
  )
  try(
  MIDsub$pb.exps[i]<-data$exp.comp[data$year==(MIDsub$endyear[i]+1) &
                                            data$statea == MIDsub$statea[i] &
                                            data$stateb == MIDsub$stateb[i] ]
  )
}

# Change in Competition
MIDsub$delta.exp.comp <- MIDsub$pb.exps - MIDsub$exp.comp
MIDsub$delta.imp.comp <- MIDsub$pb.imps - MIDsub$imp.comp

# Save progress
write_rds(MIDsub,"data/MIDsubset.rds")
write_csv(MIDsub,"data/MIDsubset.csv")

# For visualization, drop the sole observation that had hostlev == 0
length(MIDsub$hostlev[MIDsub$hostlev == 0])
MIDsub<-filter(MIDsub,hostlev > 0)

# Make Hostility Level a factor with appropriate labels
MIDsub$hostlev <- as.factor(MIDsub$hostlev)
levels(MIDsub$hostlev) <- c("No militarized action",
                            "Threat to use force",
                            "Display of force",
                            "Use of force",
                            "War")

ggplot(MIDsub,aes(exp.comp,delta.exp.comp)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE) +
  facet_wrap(~hostlev) +
  labs(title="Export Competition and Change by Hostility Level",
       x="Export Competition", y="Change in Export Competition") +
  theme_minimal()
ggsave("fig/ExpChangeHost.png",width=8,height=5)
summary(lm(delta.exp.comp~exp.comp*hostlev,MIDsub))

ggplot(MIDsub,aes(exp.comp,delta.exp.comp)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE) +
  facet_wrap(~hiact) +
  labs(title="Export Competition and Change by Highest Action",
       x="Export Competition", y="Change in Export Competition") +
  theme_minimal()
ggsave("fig/ExpChangeHiAct.png",width=8,height=5)
summary(lm(delta.exp.comp~exp.comp*hiact,MIDsub))

ggplot(MIDsub,aes(exp.comp,delta.exp.comp)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE) +
  facet_wrap(~fatality) +
  labs(title="Export Competition and Change by Fatality",
       x="Export Competition", y="Change in Export Competition") +
  theme_minimal()
ggsave("fig/ExpChangeFatal.png",width=8,height=5)
summary(lm(delta.exp.comp~exp.comp*fatality,MIDsub))