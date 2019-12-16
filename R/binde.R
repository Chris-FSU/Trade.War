library(tidyverse)
library(countrycode)

# Get interstate war data
war<-read_csv("data/cow/directed_dyadic_war.csv") %>%
  filter(warstrtyr >1961) %>%
  select(statea,stateb,warstrtyr,warendyr,warolea,waroleb,wardyadrolea,wardyadroleb)

starts<-select(war,warstrtyr,statea,stateb,wardyadrolea,wardyadroleb) %>%
  rename(year = warstrtyr) %>%
  mutate(is.war = TRUE)

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
            read_rds("data/by.year/comp1999.rds"),) %>%
  left_join(starts) %>%
  mutate(is.war = replace_na(is.war,FALSE)) %>%
  filter(country.a != country.b)
