library(tidyverse)
library(cowplot)

data<-read_csv("data/year.avgs.csv") %>%
  mutate(year = 1962:1999)

thing1 <- ggplot(data,aes(x=year)) +
  geom_point(aes(y=exp.mid),color=1) +
  geom_smooth(aes(y=exp.pax),color=1) +
  labs(title="Export Similarity and MIDs", 
       subtitle = "Points are yearly averages among MID Dyads",
       y="Export Similarity") +
  theme_minimal()

thing2 <- ggplot(data,aes(x=year)) +
  geom_point(aes(y=imp.mid),color=2) +
  geom_smooth(aes(y=imp.pax),color=2) +
  labs(title="Import Similarity and MIDs", 
       subtitle = "Points are yearly averages among MID Dyads",
       y="Import Similarity") +
  theme_minimal()

plot_grid(thing1, thing2, labels = "AUTO")
ggsave("fig/ExpImpSim.png",width=8,height=5)
