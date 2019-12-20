library(tidyverse)
library(countrycode)

# MID data
MIDA <- read_csv("data/cow/MIDA 4.3.csv") %>%
  filter(styear >1961) %>%
  select(dispnum3,styear,endyear,outcome,fatality)

MID <- read_csv("data/cow/MIDB 4.3.csv") %>%
  filter(styear >1961) %>%
  select(dispnum3, stabb, ccode, styear, endyear, hiact, hostlev, orig, sidea) %>%
  left_join(MIDA) %>%
  mutate(fatality = na_if(fatality,-9),
         outcome = na_if(outcome,-9))
rm(MIDA)

attacher<-as.data.frame(matrix(rep(0,3),ncol=3))
names(attacher)<-c("dispnum3","ccode","stateb")
each.disp<-unique(MID$dispnum3)
for (i in 1:length(each.disp)){
  side1<-MID$ccode[MID$dispnum3==each.disp[i] & MID$sidea==1]
  side0<-MID$ccode[MID$dispnum3==each.disp[i] & MID$sidea==0]
  disp<-rep(each.disp[i],length(side0)*length(side1)*2)
  ccode<-c(rep(side1,length(side0)),rep(side0,length(side1)))
  opp<-c(rep(side0,length(side1)),rep(side1,length(side0)))
  identifiers<-as.data.frame(matrix(c(disp,ccode,opp),ncol=3))
  names(identifiers)<-c("dispnum3","ccode","stateb")
  attacher<-bind_rows(attacher,identifiers)
}
war.data <- filter(attacher, dispnum3 != 0) %>%
  left_join(MID) %>%
  select(-sidea,-stabb,-orig) %>%
  rename(statea = ccode,
         year = styear)
write_rds(war.data,"data/MID.rds")
write_csv(war.data,"data/MID.csv")

# Read in a correlation set
comp<-bind_rows(read_rds("data/by.year/comp1962.rds"),
            read_rds("data/by.year/comp1963.rds"),
            read_rds("data/by.year/comp1964.rds"),
            read_rds("data/by.year/comp1965.rds"),
            read_rds("data/by.year/comp1966.rds"),
            read_rds("data/by.year/comp1967.rds"),
            read_rds("data/by.year/comp1968.rds"),
            read_rds("data/by.year/comp1969.rds"),
            read_rds("data/by.year/comp1970.rds"),
            read_rds("data/by.year/comp1971.rds"),
            read_rds("data/by.year/comp1972.rds"),
            read_rds("data/by.year/comp1973.rds"),
            read_rds("data/by.year/comp1974.rds"),
            read_rds("data/by.year/comp1975.rds"),
            read_rds("data/by.year/comp1976.rds"),
            read_rds("data/by.year/comp1977.rds"),
            read_rds("data/by.year/comp1978.rds"),
            read_rds("data/by.year/comp1979.rds"),
            read_rds("data/by.year/comp1980.rds"),
            read_rds("data/by.year/comp1981.rds"),
            read_rds("data/by.year/comp1982.rds"),
            read_rds("data/by.year/comp1983.rds"),
            read_rds("data/by.year/comp1984.rds"),
            read_rds("data/by.year/comp1985.rds"),
            read_rds("data/by.year/comp1986.rds"),
            read_rds("data/by.year/comp1987.rds"),
            read_rds("data/by.year/comp1988.rds"),
            read_rds("data/by.year/comp1989.rds"),
            read_rds("data/by.year/comp1990.rds"),
            read_rds("data/by.year/comp1991.rds"),
            read_rds("data/by.year/comp1992.rds"),
            read_rds("data/by.year/comp1993.rds"),
            read_rds("data/by.year/comp1994.rds"),
            read_rds("data/by.year/comp1995.rds"),
            read_rds("data/by.year/comp1996.rds"),
            read_rds("data/by.year/comp1997.rds"),
            read_rds("data/by.year/comp1998.rds"),
            read_rds("data/by.year/comp1999.rds")) %>%
  filter(country.a != country.b) %>%
  filter(country.a != "Afr.Other NS" &
           country.a != "Eur.Other NE" &
           country.a != "Falkland Is" &
           country.a != "Neutral Zone" &
           country.a != "Oth.Oceania" &
           country.a != "St.Helena") %>%
  filter(country.b != "Afr.Other NS" &
           country.b != "Eur.Other NE" &
           country.b != "Falkland Is" &
           country.b != "Neutral Zone" &
           country.b != "Oth.Oceania" &
           country.b != "St.Helena") %>%
  left_join(war.data)

comp$is.war<-ifelse(is.na(comp$dispnum3),0,1)
# Remove region sums
comp<-comp[-which(str_detect(comp$country.a,"NES")),]
comp<-comp[-which(str_detect(comp$country.b,"NES")),]
# Remove sub-regions of China
comp<-comp[-which(str_detect(comp$country.a,"China ")),]
comp<-comp[-which(str_detect(comp$country.b,"China ")),]

write_rds(comp,"data/comp.rds")
write_csv(comp,"data/comp.csv")

# Averages
mean(comp$exp.comp[comp$is.war==TRUE])
mean(comp$exp.comp[comp$is.war==FALSE])
mean(comp$imp.comp[comp$is.war==TRUE],na.rm=TRUE)
mean(comp$imp.comp[comp$is.war==FALSE],na.rm=TRUE)

# Many countries are in the data which did not yet exist. These need to be deleted.
# To see which ones they are, run sort(table(comp$country.b[which(is.na(comp$imp.comp))]), decreasing = TRUE) before the next line.
comp<-comp[-which(is.na(comp$imp.comp)),]

midtrue<-comp[comp$is.war==TRUE,]
midfalse<-comp[comp$is.war==FALSE,]
tapply(midtrue$exp.comp,midtrue$year,mean)
tapply(midfalse$exp.comp,midfalse$year,mean)
tapply(midtrue$imp.comp,midtrue$year,mean)
tapply(midfalse$imp.comp,midfalse$year,mean)
year.avgs<-data.frame(matrix(c(tapply(midtrue$exp.comp,midtrue$year,mean),
                    tapply(midfalse$exp.comp,midfalse$year,mean),
                    tapply(midtrue$imp.comp,midtrue$year,mean),
                    tapply(midfalse$imp.comp,midfalse$year,mean)),ncol=4))
row.names(year.avgs)<-c(1962:1999)
colnames(year.avgs)<-c("exp.mid","exp.pax","imp.mid","imp.pax")
write_csv(year.avgs,"data/year.avgs.csv")

# Fix this later
ggplot(year.avgs,aes(x=seq_along(imp.mid))) +
     geom_smooth(aes(y=year.avgs$imp.mid,col=1)) +
  geom_smooth(aes(y=year.avgs$imp.pax,col=2)) +
  geom_smooth(aes(y=year.avgs$exp.mid,col=3)) +
  geom_smooth(aes(y=year.avgs$exp.pax,col=4))
