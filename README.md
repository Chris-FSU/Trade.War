# Question
Do countries which export similar goods to the same customers fight more?

Chatagnier and Kavakli 2017 show that countries which export similar goods fight more. They did not account for competition over specific customers. They also did not examine import competition.

I further intend to examine the trade portfolios of belligerents, victims, and non-warring state-years for a descriptive analysis. This atheoretical approach might indicate which markets are more worth fighting for.

I will replicate and improve their work by adding country-specific data to the profiles, adding import competition, and describing the average differences in portfolios of belligerents, victims, and non-warring state-years.

# Current State

Comp is complete. Now it needs economic and capabilities data as control variables. I've e-mailed Tyson Chatagnier for those replication materials since the link on his website was broken.

Imports and Exports are ready for differentiation between the trade profiles of aggressors, defenders, joiners, and non-warring states.

# Correlator

This replicates the product-level correlations for exports, as C&K17 did, and for imports, which they did not. 

# Comp

data/comp has all correlations and a binary variable for whether a war was initiated in that dyad year.

# End Game
Once I have dyadic trade competition, I will regress it against MIDs from the correlates of war project with appropriate controls.

# Next

I need the control variables used in C&K17. I may have to go get them myself. I'm waiting for an e-mail response from Chatagnier.

I can also use the WITS data to try to extend this model beyond 2000.

# Data Sources
[Nber came from here](https://cid.econ.ucdavis.edu/nberus.html).

[Wits data came from here](http://wits.worldbank.org/WITS/WITS/AdvanceQuery/RawTradeData/QueryDefinition.aspx?Page=RawTradeData).

[COW data came from the Dyadic Inter-state War Dataset here](https://correlatesofwar.org/data-sets/COW-war).