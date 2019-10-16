library(tidyverse)
library(countrycode)

# load data
data <- read.csv("data/raw/3d.all18.csv",stringsAsFactors = FALSE) %>%
  # Make dyadic per product (also conveniently makes NAs numeric)
  pivot_longer(8:245,names_to="seller",values_to="value") %>%
  # Shorten seller names to just 3 letter iso3 code
  mutate(seller = str_extract(seller, pattern = "[A-Z]{3}")) %>%
  # Transform back into original format with sellers as columns
  pivot_wider(names_from=seller,values_from=value) %>%
  mutate(ccode = countrycode(ReporterISO3,'iso3c','cown'))
  

# Make a dyadic matrix of the Pearson's correlations between trade profiles.
dyadic<-as.data.frame(cor(data[,8:245],use="pairwise.complete.obs",method="pearson")) %>%
  # Make a row of the sellers
  rownames_to_column("seller.a") %>%
  # Make their names lower case (to avoid R errors)
  mutate(seller.a = str_to_lower(seller.a)) %>%
  # Move the columns into dyadic rows. This would have made errors without the previous line.
  pivot_longer(cols=2:239, names_to = "seller.b", values_to = "competition") %>%
  # Drop all of the values where the dyad is two of the same country.
  filter(seller.a != str_to_lower(seller.b)) %>%
  # Get rid of NAs. Conceptually, these are caused by countries with no exports, including potentially dead countries.
  filter(!is.na(competition)) %>%
  # Bring seller.a back into upper case (to undo the action from a few lines up).
  mutate(seller.a = str_to_upper(seller.a)) %>%
  mutate(ccode.a = countrycode(seller.a,'iso3c','cown'),
         ccode.b = countrycode(seller.b,'iso3c','cown'))

# Write those into new datasets
write_rds(dyadic,path="data/dyadic2018.rds")
write_csv(dyadic,path="data/dyadic2018.csv")

