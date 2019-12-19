# Questions
1) Do countries which export similar goods fight more?

2) Do countries which import similar goods fight more?

3) Do losers stop dealing in the same goods as victors, once the war is over?

4) Do markets in certain goods cause more fights than others?

5) Do countries which export similar goods fight over the same customers?

Chatagnier and Kavakli 2017 show that countries which export similar goods fight more. They do not examine the same effects of imports, competition over specific customers, or whether it worked.

# Results so far . . .

![](https://github.com/Chris-FSU/Trade.War/blob/master/ExpImpSim.png)

Among dyads engaged in a MID (shown with points), export similarity and import similarity are both higher than the averages among non-MID dyads (shown with shaded lines).

So far, the response to the first two questions is that countries who fight have more similar exports and imports than countries who do not fight. This suggests, but does not prove, that countries who export and import similar goods fight more.

# Current State

Comp is complete. Now it needs economic and capabilities data as control variables.

Imports and Exports are ready for differentiation between the trade profiles of aggressors, defenders, joiners, and non-warring states.

# Next

Make a dataset with all of the controls used by C&K17 for replication of their work (pursuant to Q1) and for my extension (pursuant to Q2).

I can also use the WITS data to try to extend this model beyond 2000.

Q3.R seems to show null results for Q3, but I only checked t versus (t-1). I should check at the start and end of the MID to be sure.

Pursuant to Q4, establish averages for profiles of MID and non-MID country-years. Subtract one from the other. Examine whether the largest absolute values have some feature in common (for example, high rent-seeking potential).

Q5 will be a doozy. I need a triadic dataset of trade portfolios and MIDs. Check all MID dyads for high levels of exports to the same country cs. Assuming Q4 yields positive results, these country cs will likely be purchasing large volumes of those goods. 

# End Game
Regress export similarity and import similarity against MIDs from the correlates of war project with appropriate controls. (Pursuant to Q1 & Q2)

Compare antebellum and post-bellum trade similarities. (Q3)

Determine whether some common feature exists between exports over which dyads tend to fight. (Q4)

Determine whether fighting dyads tend to export large volumes of goods to the same customers (Q5)

# Data Sources
[Chatagnier and Kavakli's article can be found here](https://journals.sagepub.com/doi/abs/10.1177/0022002715613565?journalCode=jcrb).

[Nber came from here](https://cid.econ.ucdavis.edu/nberus.html).

[Wits data came from here](http://wits.worldbank.org/WITS/WITS/AdvanceQuery/RawTradeData/QueryDefinition.aspx?Page=RawTradeData).

[COW data came from the Dyadic Inter-state War Dataset here](https://correlatesofwar.org/data-sets/COW-war).