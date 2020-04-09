library(tidyverse)
library(cowplot)

data<-read_csv("data/year.avgs.csv") %>%
  mutate(year = 1962:1999)

thing1 <- ggplot(data,aes(x=year)) +
  geom_smooth(aes(y=exp.mid),color=2,method="lm") +
  geom_smooth(aes(y=exp.pax),color=1,method="lm") +
  labs(title="Export Similarity and MIDs",
       y="Export Similarity") +
  theme_minimal()

thing2 <- ggplot(data,aes(x=year)) +
  geom_smooth(aes(y=imp.mid),color=2,method="lm") +
  geom_smooth(aes(y=imp.pax),color=1,method="lm") +
  labs(title="Import Similarity and MIDs",
       y="Import Similarity") +
  theme_minimal()

plot_grid(thing1, thing2, labels = "AUTO")
#ggsave("fig/ExpImpSim.png",width=8,height=5)


data<-read_csv("data/comp.csv")

data$is.war <-as.logical(data$is.war)
thing3<-ggplot(data,aes(y=exp.comp,x=is.war)) +
  geom_violin() +
  geom_boxplot(width=0.1) +
  labs(title="Export Similarity and MIDs",
       y="Export Similarity",
       x="Is a MID occuring in this Dyad-Year?") +
  theme_minimal()

thing4<-ggplot(data,aes(y=imp.comp,x=is.war)) +
  geom_violin() +
  geom_boxplot(width=0.1) +
  labs(title="Import Similarity and MIDs",
       y="Import Similarity",
       x="Is a MID occuring in this Dyad-Year?") +
  theme_minimal()

plot_grid(thing3, thing4, labels = "AUTO")
ggsave("fig/ExpImpSim.png",width=8,height=5)

# Summary Statistics for Comparison
summarized<-matrix(c(summary(data$exp.comp[data$is.war==TRUE])[2:5],
summary(data$exp.comp[data$is.war==FALSE])[2:5],
summary(data$imp.comp[data$is.war==TRUE])[2:5],
summary(data$imp.comp[data$is.war==FALSE])[2:5]),ncol=4,byrow=TRUE)
colnames(summarized)<-c("1st Quartile","Median","Mean","3rd Quartile")
rownames(summarized)<-c("MID Exports","No MID Exports","MID Imports","No MID Imports")
summarized
