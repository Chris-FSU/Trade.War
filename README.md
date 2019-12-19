# Question
1) Do countries which export similar goods fight more?

2) Do countries which import similar goods fight more?

3) Do losers stop dealing in the same goods as victors, once the war is over?

4) Do certain markets cause more fights than others?

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

I need the control variables used in C&K17. I have their replication data.

I can also use the WITS data to try to extend this model beyond 2000.

To answer question 3, I will need a dataset of the portfolio similarities of each MID dyad at the beginning and end of each MID.

# End Game
Once I have dyadic trade competition, I will regress it against MIDs from the correlates of war project with appropriate controls.

# Data Sources
[Chatagnier and Kavakli's article can be found here](https://journals.sagepub.com/doi/abs/10.1177/0022002715613565?journalCode=jcrb).

[Nber came from here](https://cid.econ.ucdavis.edu/nberus.html).

[Wits data came from here](http://wits.worldbank.org/WITS/WITS/AdvanceQuery/RawTradeData/QueryDefinition.aspx?Page=RawTradeData).

[COW data came from the Dyadic Inter-state War Dataset here](https://correlatesofwar.org/data-sets/COW-war).