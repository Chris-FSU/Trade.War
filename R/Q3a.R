# Do trade similarities decrease over the duration of a MID?

library(tidyverse)

# You can skip this CPU-intensive data processing by loading the csv on line 40.

data<- read_rds("data/comp.rds") %>%
  filter(!is.na(statea),
         !is.na(stateb))

# Make a dataset of just the MID dyadyears
MIDsub<-data[!is.na(data$dispnum3),]
MIDsub$pb.imps<- MIDsub$pb.exps<- NA

# This creates a variable for trade competition at t2. This is for later comparison.
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

# To Save progress, uncomment these two lines:
# write_rds(MIDsub,"data/MIDsubset.rds")
# write_csv(MIDsub,"data/MIDsubset.csv")

# If you've ran everything above before, you can retrieve the data by 
# uncommenting the next line:
MIDsub <- read_csv("data/MIDsubset.csv")

# For visualization, drop the sole observation that had hostlev == 0
length(MIDsub$hostlev[MIDsub$hostlev == 0])
MIDsub<-filter(MIDsub,hostlev > 0)

## The charts below show that similarity between A and B from t1 to t2.

# Make Hostility Level a factor with appropriate labels
MIDsub$hostlev <- as.factor(MIDsub$hostlev)
levels(MIDsub$hostlev) <- c("No militarized action",
                            "Threat to use force",
                            "Display of force",
                            "Use of force",
                            "War")


ggplot(MIDsub,aes(exp.comp,pb.exps,color=hostlev)) +
  geom_smooth(method="lm", se=TRUE) +
  labs(title="Do MIDs Reduce Trade Competition?",
       subtitle = "Reduction in Trade Competition During MID",
       x="Pre-MID Export Competition", y="Post-MID Export Competition") +
  theme_minimal() +
  geom_abline(slope=1) +
  scale_color_brewer(palette = "YlOrRd")
# ggsave("fig/ExpChangeHost1.png",width=8,height=5)
MIDsub$hostlev <- as.numeric(MIDsub$hostlev)
summary(lm(delta.exp.comp~exp.comp*hostlev,MIDsub))

ggplot(MIDsub,aes(exp.comp,delta.exp.comp)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE) +
  facet_wrap(~hiact) +
  labs(title="Export Competition and Change by Highest Action",
       x="Export Competition", y="Change in Export Competition") +
  theme_minimal()
# ggsave("fig/ExpChangeHiAct.png",width=8,height=5)

summary(lm(delta.exp.comp~exp.comp*hiact,MIDsub))
ggplot(MIDsub,aes(exp.comp,delta.exp.comp)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE) +
  facet_wrap(~fatality) +
  labs(title="Export Competition and Change by Fatality",
       x="Export Competition", y="Change in Export Competition") +
  theme_minimal()
# ggsave("fig/ExpChangeFatal.png",width=8,height=5)
summary(lm(delta.exp.comp~exp.comp*fatality,MIDsub))

victors<-MIDsub[MIDsub$victor==TRUE,]
victors<-victors[!is.na(victors$country.a),]
# write_rds(victors,"data/victors.rds")
# write_csv(victors,"data/victors.csv")
losers<-MIDsub[MIDsub$loser==TRUE,]
losers<-losers[!is.na(losers$country.a),]
# write_rds(losers,"data/losers.rds")
# write_csv(losers,"data/losers.csv")
neither<-MIDsub[MIDsub$victor==FALSE & MIDsub$loser==FALSE,]
neither<-neither[!is.na(neither$country.a),]
# write_rds(neither,"data/neither.rds")
# write_csv(neither,"data/neither.csv")
