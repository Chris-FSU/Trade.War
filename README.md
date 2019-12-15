# Question
Do countries which export similar goods to the same customers fight more?

Chatagnier and Kavakli 2017 show that countries which export similar goods fight more. They did not account for competition over specific customers. They also did not examine import competition.

I further intend to examine the trade portfolios of belligerents, victims, and non-warring state-years for a descriptive analysis.

I will replicate and improve their work by adding country-specific data to the profiles, adding import competition, and describing the average differences in portfolios of belligerents, victims, and non-warring state-years.

# Current State

Many of the correlations have been completed. 1994 has given the code trouble. It seems that there is at least one duplicate value for the same importer, exporter, product code, and year.

# Proof of Concept
proof.of.concept.R applied Pearson's correlation to trade profiles from 3d.all18.csv to create dyadic2018.rds

I can use this same process to create dyadic trade competition profiles for each year.

# Correlator

This replicates the product-level correlations for exports, as C&K17 did, and for imports, which they did not. 

Once I have finished processing these data, I will bind them with war data to replicate C&K17's results and expand them

# End Game
Once I have dyadic trade competition, I will regress it against MIDs from the correlates of war project with appropriate controls.

# Next

Next I'll examine the monadic trade portfolios of aggressors, victims, and non-warring state-years. 
I predict higher proportions of certain exports from aggressors and victims. Goods from which rents can easily be extracted are more valuable prizes and narrow the bargaining window.

# Data Sources
[Nber came from here](https://cid.econ.ucdavis.edu/nberus.html).
[Wits data came from here.](http://wits.worldbank.org/WITS/WITS/AdvanceQuery/RawTradeData/QueryDefinition.aspx?Page=RawTradeData)